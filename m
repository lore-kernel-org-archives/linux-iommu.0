Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9956BC433EF
	for <iommu@archiver.kernel.org>; Tue,  7 Dec 2021 09:46:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1356660613;
	Tue,  7 Dec 2021 09:46:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XQ9HxXQTwnM6; Tue,  7 Dec 2021 09:46:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7A530605C0;
	Tue,  7 Dec 2021 09:46:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52ED4C001E;
	Tue,  7 Dec 2021 09:46:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5ED2C0012
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 09:46:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 92FEE60613
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 09:46:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hn2OU_zkKWSs for <iommu@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 09:46:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 738AF605C0
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 09:46:28 +0000 (UTC)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4J7b3l1csszXdWF;
 Tue,  7 Dec 2021 17:44:19 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 7 Dec 2021 17:46:23 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 7 Dec 2021 17:46:23 +0800
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
 <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/1] iommu/arm-smmu-v3: Simplify useless instructions in
 arm_smmu_cmdq_build_cmd()
Date: Tue, 7 Dec 2021 17:41:09 +0800
Message-ID: <20211207094109.1962-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20211207094109.1962-1-thunder.leizhen@huawei.com>
References: <20211207094109.1962-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: Zhen Lei via iommu <iommu@lists.linux-foundation.org>
Reply-To: Zhen Lei <thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Although the parameter 'cmd' is always passed by a local array variable,
and only this function modifies it, the compiler does not know this. Every
time the 'cmd' variable is updated, a memory write operation is generated.
This generates many useless instruction operations.

To guide the compiler for proper optimization, 'cmd' is defined as a local
array variable, and copied to the output parameter at a time when the
function is returned.

The optimization effect can be viewed by running the "size arm-smmu-v3.o"
command.

Before:
   text    data     bss     dec     hex
  28246    1332      56   29634    73c2

After:
   text    data     bss     dec     hex
  28134    1332      56   29522    7352

For example:
	cmd[0] = FIELD_PREP(CMDQ_0_OP, ent->opcode);
case CMDQ_OP_TLBI_EL2_VA:
	cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_NUM, ent->tlbi.num);
	cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_SCALE, ent->tlbi.scale);
	cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_ASID, ent->tlbi.asid);
	cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_LEAF, ent->tlbi.leaf);
	cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_TTL, ent->tlbi.ttl);
	cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_TG, ent->tlbi.tg);
	cmd[1] |= ent->tlbi.addr & CMDQ_TLBI_1_VA_MASK;

Before:
  Each "cmd[0] |=" or "cmd[1] |=" operation generates a "str" instruction,
sum = 8.

     ldrb	w4, [x1, #8]		//w4 = ent->tlbi.num
     ubfiz	x4, x4, #12, #5
     mov	w0, #0x0
     orr	x4, x4, x3
     str	x4, [x2]
     autiasp
     ldrb	w3, [x1, #9]		//w3 = ent->tlbi.scale
     ubfiz	x3, x3, #20, #5
     orr	x3, x3, x4
     str	x3, [x2]
     ldrh	w4, [x1, #10]		//w4 = ent->tlbi.asid
     orr	x3, x3, x4, lsl #48
     str	x3, [x2]
     ldrb	w3, [x1, #14]		//w3 = ent->tlbi.leaf
     str	x3, [x2, #8]
     ldrb	w4, [x1, #15]		//w4 = ent->tlbi.ttl
     ubfiz	x4, x4, #8, #2
     orr	x4, x4, x3
     str	x4, [x2, #8]
     ldrb	w3, [x1, #16]		//ent->tlbi.tg
     ubfiz	x3, x3, #10, #2
     orr	x3, x3, x4
     str	x3, [x2, #8]
     ldr	x1, [x1, #24]		//ent->tlbi.addr
     and	x1, x1, #0xfffffffffffff000
     orr	x1, x1, x3
     str	x1, [x2, #8]
     ret

After:
  All "cmd[0] |=" and "cmd[1] |=" operations generate a "stp" instruction,
sum = 1.

3e8:
     mov	w0, #0x0
     autiasp
     stp	x2, x1, [x3]
     ret
     bti	j
3fc:
     ldrb	w5, [x1, #8]		//w5 = ent->tlbi.num
     mov	x2, #0x22		//x2 = ent->opcode = CMDQ_0_OP
     ldrb	w6, [x1, #9]		//w6 = ent->tlbi.scale
     ubfiz	x5, x5, #12, #5
     ldrb	w0, [x1, #16]		//w0 = ent->tlbi.tg
     orr	x5, x5, x2
     ldrb	w7, [x1, #15]		//w7 = ent->tlbi.ttl
     ldr	x4, [x1, #24]		//x4 = ent->tlbi.addr
     ubfiz	x0, x0, #10, #2
     ldrh	w2, [x1, #10]		//w2 = ent->tlbi.asid
     ubfiz	x6, x6, #20, #5
     ldrb	w8, [x1, #14]		//w8 = ent->tlbi.leaf
     and	x4, x4, #0xfffffffffffff000
     ubfiz	x1, x7, #8, #2
     orr	x1, x0, x1
     orr	x2, x6, x2, lsl #48
     orr	x0, x4, x8
     orr	x2, x2, x5
     orr	x1, x1, x0
     b		3e8

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f5848b351b19359..e55dfc14cac6005 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -234,10 +234,12 @@ static int queue_remove_raw(struct arm_smmu_queue *q, u64 *ent)
 }
 
 /* High-level queue accessors */
-static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
+static int arm_smmu_cmdq_build_cmd(u64 *out_cmd, struct arm_smmu_cmdq_ent *ent)
 {
-	memset(cmd, 0, 1 << CMDQ_ENT_SZ_SHIFT);
-	cmd[0] |= FIELD_PREP(CMDQ_0_OP, ent->opcode);
+	int i;
+	u64 cmd[CMDQ_ENT_DWORDS] = {0};
+
+	cmd[0] = FIELD_PREP(CMDQ_0_OP, ent->opcode);
 
 	switch (ent->opcode) {
 	case CMDQ_OP_TLBI_EL2_ALL:
@@ -332,6 +334,9 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 		return -ENOENT;
 	}
 
+	for (i = 0; i < CMDQ_ENT_DWORDS; i++)
+		out_cmd[i] = cmd[i];
+
 	return 0;
 }
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
