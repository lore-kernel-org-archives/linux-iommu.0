Return-Path: <SRS0=/53O=JI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0544DC433B4
	for <iommu@archiver.kernel.org>; Sun, 11 Apr 2021 23:38:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 670F4611F0
	for <iommu@archiver.kernel.org>; Sun, 11 Apr 2021 23:38:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 670F4611F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 25712403B9;
	Sun, 11 Apr 2021 23:38:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IKcex2UkAAwO; Sun, 11 Apr 2021 23:38:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id EA4E840143;
	Sun, 11 Apr 2021 23:38:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7D76C000C;
	Sun, 11 Apr 2021 23:38:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97884C000A
 for <iommu@lists.linux-foundation.org>; Sun, 11 Apr 2021 23:38:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7926C403CA
 for <iommu@lists.linux-foundation.org>; Sun, 11 Apr 2021 23:38:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9jRfXvF5BsZ0 for <iommu@lists.linux-foundation.org>;
 Sun, 11 Apr 2021 23:38:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from smtprelay.hostedemail.com (smtprelay0247.hostedemail.com
 [216.40.44.247])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0AD5E403C9
 for <iommu@lists.linux-foundation.org>; Sun, 11 Apr 2021 23:38:08 +0000 (UTC)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave01.hostedemail.com (Postfix) with ESMTP id 2BEDB18037BDC
 for <iommu@lists.linux-foundation.org>; Sun, 11 Apr 2021 22:21:55 +0000 (UTC)
Received: from omf04.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
 by smtprelay06.hostedemail.com (Postfix) with ESMTP id 3B5EF1801A773;
 Sun, 11 Apr 2021 22:21:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by
 omf04.hostedemail.com (Postfix) with ESMTPA id 2902BD1513; 
 Sun, 11 Apr 2021 22:21:51 +0000 (UTC)
Message-ID: <0362ad3912473d24e5927c0b54ed8fd3648c68a9.camel@perches.com>
Subject: Re: [PATCH v2] iommu/amd: Fix extended features logging
From: Joe Perches <joe@perches.com>
To: Alexander Monakov <amonakov@ispras.ru>, linux-kernel@vger.kernel.org
Date: Sun, 11 Apr 2021 15:21:49 -0700
In-Reply-To: <20210411211330.2252-1-amonakov@ispras.ru>
References: <20210411211330.2252-1-amonakov@ispras.ru>
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 2902BD1513
X-Stat-Signature: 9q8g74u5wmyjuhdqzmu6sgk8n19m8uoo
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19fWofgnuzzhGoeM7lXW+imT0hmBDHhTow=
X-HE-Tag: 1618179711-799595
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, iommu@lists.linux-foundation.org,
 Joerg Roedel <jroedel@suse.de>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, 2021-04-12 at 00:13 +0300, Alexander Monakov wrote:
> print_iommu_info prints the EFR register and then the decoded list of
> features on a separate line:
> =

> pci 0000:00:00.2: AMD-Vi: Extended features (0x206d73ef22254ade):
> =A0PPR X2APIC NX GT IA GA PC GA_vAPIC
> =

> The second line is emitted via 'pr_cont', which causes it to have a
> different ('warn') loglevel compared to the previous line ('info').
> =

> Commit 9a295ff0ffc9 attempted to rectify this by removing the newline
> from the pci_info format string, but this doesn't work, as pci_info
> calls implicitly append a newline anyway.
> =

> Printing the decoded features on the same line would make it quite long.
> Instead, change pci_info() to pr_info() to omit PCI bus location info,
> which is shown in the preceding message anyway. This results in:
> =

> pci 0000:00:00.2: AMD-Vi: Found IOMMU cap 0x40
> AMD-Vi: Extended features (0x206d73ef22254ade): PPR X2APIC NX GT IA GA PC=
 GA_vAPIC
> AMD-Vi: Interrupt remapping enabled
> =

> Fixes: 9a295ff0ffc9 ("iommu/amd: Print extended features in one line to f=
ix divergent log levels")
> Link: https://lore.kernel.org/lkml/alpine.LNX.2.20.13.2104112326460.11104=
@monopod.intra.ispras.ru
> Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
> Cc: Paul Menzel <pmenzel@molgen.mpg.de>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Cc: iommu@lists.linux-foundation.org
> ---
> =

> v2: avoid pr_info(""), change pci_info() to pr_info() for a nicer
> solution
> =

> =A0drivers/iommu/amd/init.c | 4 ++--
> =A01 file changed, 2 insertions(+), 2 deletions(-)
> =

> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 596d0c413473..62913f82a21f 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -1929,8 +1929,8 @@ static void print_iommu_info(void)
> =A0		pci_info(pdev, "Found IOMMU cap 0x%hx\n", iommu->cap_ptr);
> =A0
> =

> =A0		if (iommu->cap & (1 << IOMMU_CAP_EFR)) {
> -			pci_info(pdev, "Extended features (%#llx):",
> -				 iommu->features);
> +			pr_info("Extended features (%#llx):", iommu->features);
> +
> =A0			for (i =3D 0; i < ARRAY_SIZE(feat_str); ++i) {
> =A0				if (iommu_feature(iommu, (1ULL << i)))
> =A0					pr_cont(" %s", feat_str[i]);

How about avoiding all of this by using a temporary buffer
and a single pci_info.

Miscellanea:
o Move the feat_str and i declarations into the if block for locality

---
 drivers/iommu/amd/init.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 321f5906e6ed..0d219044726e 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1943,30 +1943,37 @@ static int __init iommu_init_pci(struct amd_iommu *=
iommu)
 =

 static void print_iommu_info(void)
 {
-	static const char * const feat_str[] =3D {
-		"PreF", "PPR", "X2APIC", "NX", "GT", "[5]",
-		"IA", "GA", "HE", "PC"
-	};
 	struct amd_iommu *iommu;
 =

 	for_each_iommu(iommu) {
 		struct pci_dev *pdev =3D iommu->dev;
-		int i;
 =

 		pci_info(pdev, "Found IOMMU cap 0x%x\n", iommu->cap_ptr);
 =

 		if (iommu->cap & (1 << IOMMU_CAP_EFR)) {
-			pci_info(pdev, "Extended features (%#llx):",
-				 iommu->features);
+			static const char * const feat_str[] =3D {
+				"PreF", "PPR", "X2APIC", "NX", "GT", "[5]",
+				"IA", "GA", "HE", "PC"
+			};
+			int i;
+			char features[128] =3D "";
+			int len =3D 0;
+
 			for (i =3D 0; i < ARRAY_SIZE(feat_str); ++i) {
-				if (iommu_feature(iommu, (1ULL << i)))
-					pr_cont(" %s", feat_str[i]);
+				if (!iommu_feature(iommu, BIT_ULL(i)))
+					continue;
+				len +=3D scnprintf(features + len,
+						 sizeof(features) - len,
+						 " %s", feat_str[i]);
 			}
 =

 			if (iommu->features & FEATURE_GAM_VAPIC)
-				pr_cont(" GA_vAPIC");
+				len +=3D scnprintf(features + len,
+						 sizeof(features) - len,
+						 " %s", "GA_vPIC");
 =

-			pr_cont("\n");
+			pci_info(pdev, "Extended features (%#llx):%s\n",
+				 iommu->features, features);
 		}
 	}
 	if (irq_remapping_enabled) {


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
