Return-Path: <SRS0=Lu7X=XA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6AEC43331
	for <iommu@archiver.kernel.org>; Thu,  5 Sep 2019 17:09:54 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C98FF20870
	for <iommu@archiver.kernel.org>; Thu,  5 Sep 2019 17:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fm92g6MJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C98FF20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6FF101926;
	Thu,  5 Sep 2019 17:09:53 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1B21C16A7
	for <iommu@lists.linux-foundation.org>;
	Thu,  5 Sep 2019 17:09:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
	[209.85.210.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E4D677DB
	for <iommu@lists.linux-foundation.org>;
	Thu,  5 Sep 2019 17:09:50 +0000 (UTC)
Received: by mail-ot1-f67.google.com with SMTP id g16so2908490otp.12
	for <iommu@lists.linux-foundation.org>;
	Thu, 05 Sep 2019 10:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:subject:to:cc:message-id:date:user-agent:mime-version
	:content-language:content-transfer-encoding;
	bh=zvuZJm/OeGnitqg6mopzWwdjJ0Sb1OWjOsDK5ScpN2k=;
	b=fm92g6MJUiNSxClpUlSh5+9QxkTe9Rh6e+PN6S0HdCgK1xYCEHylPDWfFgsXzbSzVY
	8tic8eObcyj6QB4OGaqYMR4F+jAqIOecKiDKfOk69dUs5tbdt4MD1Pmle3ypkjcUOF6C
	swexo56txxBOz0g++imEeemrFWDsG135wPPweBXrlulhzJGbK9yqHYoycVPku+PHJrfA
	1TY767slE0gfetOwrAVel0tqMZnuoEMMjhAVFEcC+SwUvQzTg3t7grtqShIuShmYfrw7
	7tMV+ktncJrXHJK1cU+oTbA1O1hC150dGKuz+mgVa3IGffGWcu2d+XnBtjQkMe86xo5H
	rzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
	:mime-version:content-language:content-transfer-encoding;
	bh=zvuZJm/OeGnitqg6mopzWwdjJ0Sb1OWjOsDK5ScpN2k=;
	b=dODu86BsxSuCu4TsXO2AVMnlbpQME/tNAHwAa4W15MdUhZNmpD/LfuD8ouIlR1068u
	rLjYLhKU5xaCZdqi04PbaNKuVtgu3pPHrXSlW0yoQErTPko1D1HfXjATMu9JslGS/XiY
	bQ/VQXYdGKkILLwCLZ6uDZVKbn/ox236KUIiQZ/x68Tv9tZvh6bm13xWd8Ovr7j9rtDG
	7Pj6DlII4ORZno5gYMbPZHPp1W01hl4o6tJEMJE5ebsU9OOg+Rt8n0/RIXMQP6LlesOI
	X16TofZI1GRytDGgBUnV102b4cFVO+LDpIMFKcKm24Yb629GeHS7URGaDNXHPw53IhOx
	DcsQ==
X-Gm-Message-State: APjAAAX6cbLnlPQDbDkygBPLnWjjIx06PJNBecjkeCMLySv0gtSD78DR
	iRRZ6NYuqBrc26to1Ur31975sBqPmlk=
X-Google-Smtp-Source: APXvYqw3BxLF96Sw44HP46EvQNq1DGMg29f4vt4sDfe3puJSl55/vBXNEzcOWlxI+Vt4PHHLENUNxQ==
X-Received: by 2002:a05:6830:6:: with SMTP id c6mr3285609otp.331.1567703389824;
	Thu, 05 Sep 2019 10:09:49 -0700 (PDT)
Received: from [100.71.96.87] ([143.166.81.254])
	by smtp.gmail.com with ESMTPSA id b10sm669790oie.27.2019.09.05.10.09.48
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 05 Sep 2019 10:09:49 -0700 (PDT)
From: Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH] amd/iommu: flush old domains in kdump kernel
To: jroedel@suse.de
Message-ID: <9d271f88-949a-7356-c516-be95b1566c94@gmail.com>
Date: Thu, 5 Sep 2019 12:09:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

When devices are attached to the amd_iommu in a kdump kernel, the old device
table entries (DTEs), which were copied from the crashed kernel, will be
overwritten with a new domain number.  When the new DTE is written, the IOMMU
is told to flush the DTE from its internal cache--but it is not told to flush
the translation cache entries for the old domain number.

Without this patch, AMD systems using the tg3 network driver fail when kdump
tries to save the vmcore to a network system, showing network timeouts and
(sometimes) IOMMU errors in the kernel log.

This patch will flush IOMMU translation cache entries for the old domain when
a DTE gets overwritten with a new domain number.


Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>

---

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index b607a92..f853b96 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1143,6 +1143,17 @@ static void amd_iommu_flush_tlb_all(struct amd_iommu *iommu)
 	iommu_completion_wait(iommu);
 }
 
+static void amd_iommu_flush_tlb_domid(struct amd_iommu *iommu, u32 dom_id)
+{
+	struct iommu_cmd cmd;
+
+	build_inv_iommu_pages(&cmd, 0, CMD_INV_IOMMU_ALL_PAGES_ADDRESS,
+			      dom_id, 1);
+	iommu_queue_command(iommu, &cmd);
+
+	iommu_completion_wait(iommu);
+}
+
 static void amd_iommu_flush_all(struct amd_iommu *iommu)
 {
 	struct iommu_cmd cmd;
@@ -1873,6 +1884,7 @@ static void set_dte_entry(u16 devid, struct protection_domain *domain,
 {
 	u64 pte_root = 0;
 	u64 flags = 0;
+	u32 old_domid;
 
 	if (domain->mode != PAGE_MODE_NONE)
 		pte_root = iommu_virt_to_phys(domain->pt_root);
@@ -1922,8 +1934,20 @@ static void set_dte_entry(u16 devid, struct protection_domain *domain,
 	flags &= ~DEV_DOMID_MASK;
 	flags |= domain->id;
 
+	old_domid = amd_iommu_dev_table[devid].data[1] & DEV_DOMID_MASK;
 	amd_iommu_dev_table[devid].data[1]  = flags;
 	amd_iommu_dev_table[devid].data[0]  = pte_root;
+
+	/*
+	 * A kdump kernel might be replacing a domain ID that was copied from
+	 * the previous kernel--if so, it needs to flush the translation cache
+	 * entries for the old domain ID that is being overwritten
+	 */
+	if (old_domid) {
+		struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
+
+		amd_iommu_flush_tlb_domid(iommu, old_domid);
+	}
 }
 
 static void clear_dte_entry(u16 devid)


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
