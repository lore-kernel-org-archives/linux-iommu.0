Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.248.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BB31E5721
	for <iommu@lists.linux.dev>; Fri,  8 Nov 2024 12:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.248.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731067749; cv=none; b=PqjBcDbTpjUVEmrdTCcAoVNQdMaB2tnEmmXu8HIRaAlY47kBseOJB2i+TkN6yIQRTlfODINpXh8b0S+sP+SNsBRdcAzFdnYDpXxikHqqfS5awmWNogwN44rJP1MWbqGLnMx2v1QzZlckgD8cLwkjpXeBVaGIGwvuDOvLdxqaje4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731067749; c=relaxed/simple;
	bh=EYV1tnRpjTsIOU6yPXGuIMkh+G91GY/ziHqLtllBcWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oN25bSDQqdoQw+0Kkr5Xd1QC7tErmdyW5NufPaOFMT5D07ZqSfbZZQmH6xjZJZiWf/+rAbBJu9eGdvw8kafWKlpr3eESCkNoSovEdTEX/iDqVAv9UcW8OVvNPVysd4ILVqoZjBMPn1kZvHumpNs9s5MlfS2LwTv9pgmrNDEYSHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=uKvu1lsd; arc=none smtp.client-ip=159.100.248.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="uKvu1lsd"
Received: from relay1.mymailcheap.com (relay1.mymailcheap.com [149.56.97.132])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id B460E26760
	for <iommu@lists.linux.dev>; Fri,  8 Nov 2024 12:08:59 +0000 (UTC)
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay1.mymailcheap.com (Postfix) with ESMTPS id 600DF3E955;
	Fri,  8 Nov 2024 12:08:51 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id 32E2440078;
	Fri,  8 Nov 2024 12:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1731067730; bh=EYV1tnRpjTsIOU6yPXGuIMkh+G91GY/ziHqLtllBcWw=;
	h=From:To:Cc:Subject:Date:From;
	b=uKvu1lsd/WuBSUXjl/93iSz57GA0lqMS4NHmZgIhIVbRRGBAEhdkKTwBWkMvrLNyT
	 E95wfzlJfO8YVlr0muXSXfjP4O83JATmAITmGynJ3xpS2fjErW8C0OFh9/HjHRi3gP
	 xBEt5wFExCQ4aKRWY4qV1AC8DsO+3DleLur17cTU=
Received: from JellyNote.localdomain (unknown [38.179.66.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 6451A40493;
	Fri,  8 Nov 2024 12:08:46 +0000 (UTC)
From: Mingcong Bai <jeffbai@aosc.io>
To: baolu.lu@linux.intel.com
Cc: kexybiscuit@aosc.io,
	weiguangtwk@outlook.com,
	Mingcong Bai <jeffbai@aosc.io>,
	David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] iommu: intel: apply quirk_iommu_igfx for 8086:0044 (QM57/QS57)
Date: Fri,  8 Nov 2024 20:08:21 +0800
Message-ID: <20241108120838.495931-1-jeffbai@aosc.io>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.40 / 10.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	SPFBL_URIBL_EMAIL_FAIL(0.00)[weiguangtwk.outlook.com:server fail,jeffbai.aosc.io:server fail];
	FREEMAIL_CC(0.00)[aosc.io,outlook.com,infradead.org,8bytes.org,kernel.org,arm.com,lists.linux.dev,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[outlook.com];
	RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: nf1.mymailcheap.com
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 32E2440078

(I'm not very confident about the approach of this patch but I failed to
find a better way to address the issue I have on hand, so please consider
this patch as an RFC...)

On the Lenovo ThinkPad X201, when Intel VT-d is enabled in the BIOS, the
kernel boots with errors related to DMAR, the graphical interface appeared
quite choppy, and the system resets erratically within a minute after it
booted:

DMAR: DRHD: handling fault status reg 3
DMAR: [DMA Write NO_PASID] Request device [00:02.0] fault addr 0xb97ff000
[fault reason 0x05] PTE Write access is not set

Upon comparing boot logs with VT-d on/off, I found that the Intel Calpella
quirk (`quirk_calpella_no_shadow_gtt()') correctly applied the igfx IOMMU
disable/quirk correctly:

pci 0000:00:00.0: DMAR: BIOS has allocated no shadow GTT; disabling IOMMU
for graphics

Whereas with VT-d on, it went into the "else" branch, which then
triggered the DMAR handling fault above:

... else if (!disable_igfx_iommu) {
	/* we have to ensure the gfx device is idle before we flush */
	pci_info(dev, "Disabling batched IOTLB flush on Ironlake\n");
	iommu_set_dma_strict();
}

Now, this is not exactly scientific, but moving 0x0044 to quirk_iommu_igfx
seems to have fixed the aforementioned issue. Running a few `git blame'
runs on the function, I have found that the quirk was originally
introduced as a fix specific to ThinkPad X201:

commit 9eecabcb9a92 ("intel-iommu: Abort IOMMU setup for igfx if BIOS gave
no shadow GTT space")

Which was later revised twice to the "else" branch we saw above:

- 2011: commit 6fbcfb3e467a ("intel-iommu: Workaround IOTLB hang on
  Ironlake GPU")
- 2024: commit ba00196ca41c ("iommu/vt-d: Decouple igfx_off from graphic
  identity mapping")

I'm uncertain whether further testings on this particular laptops were
done in 2011 and (honestly I'm not sure) 2024, but I would be happy to do
some distro-specific testing if that's what would be required to verify
this patch.

P.S., I also see IDs 0x0040, 0x0062, and 0x006a listed under the same
`quirk_calpella_no_shadow_gtt()' quirk, but I'm not sure how similar these
chipsets are (if they share the same issue with VT-d or even, indeed, if
this issue is specific to a bug in the Lenovo BIOS). With regards to
0x0062, it seems to be a Centrino wireless card, but not a chipset?

I have also listed a couple (distro and kernel) bug reports below as
references (some of them are from 7-8 years ago!), as they seem to be
similar issue found on different Westmere/Ironlake, Haswell, and Broadwell
hardware setups.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=197029
Link: https://groups.google.com/g/qubes-users/c/4NP4goUds2c?pli=1
Link: https://bugs.archlinux.org/task/65362
Link: https://bbs.archlinux.org/viewtopic.php?id=230323
Reported-by: Wenhao Sun <weiguangtwk@outlook.com>
Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
---
 drivers/iommu/intel/iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index e860bc9439a2..1ccea83c2c95 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4646,6 +4646,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e30, quirk_iommu_igfx);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e40, quirk_iommu_igfx);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e90, quirk_iommu_igfx);
 
+/* QM57/QS57 integrated gfx malfunctions with dmar */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0044, quirk_iommu_igfx);
+
 /* Broadwell igfx malfunctions with dmar */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1606, quirk_iommu_igfx);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x160B, quirk_iommu_igfx);
@@ -4723,7 +4726,6 @@ static void quirk_calpella_no_shadow_gtt(struct pci_dev *dev)
 	}
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0040, quirk_calpella_no_shadow_gtt);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0044, quirk_calpella_no_shadow_gtt);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0062, quirk_calpella_no_shadow_gtt);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x006a, quirk_calpella_no_shadow_gtt);
 
-- 
2.47.0

