Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795170966;
	b=nNdK3XGVmpbfK+z25/8FD8VyfUbxOIFqGMKTmtpGFp7uaPk4X2XS4cqnqCKGnDii9FMF
	 RDyQ7KC3WpRo+j9lGbQojzLdswa7w6pPofJ3WwWBY+3yc8hhT8o4AU/lIDMuBAYpnIHIx
	 THMlcbkuhf6jaO2Mpkgv5YRnwBLKgRnsYMXU8z82WSmaAiKzOQpa8Srr6b/BUp6LYyrXU
	 27da5J3durTxsJZRSiQvshF//PmaRNXKKQe3l3FjvEB6vEXIFb7B9j6Tqxb/MYpdjK8cu
	 TF/fMpq4hj1FV+iY1Nkq1fY5HyjZDDPUKl6+JcRgbJzsdaswXfCfWo1I7ZXmFj3s04w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795170966;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Jja5CIRJx6p71jdLiDhzh91wfoRIZk+1zpGerhUQBKg=;
	b=tHk3/xZwDlLrQVi6iABZXiBw5OiJIrX5f3Mq7pTXUbV9r2lRF5sQNh3JxEUVz9knybN7
	 7D2DJwOYpyMVsUXI2feO3+7spCPdcF71Zhz7w7tTeTcyFX4GPr1PeLGgQk5ZBuLZMJOIR
	 sr3Z9Al6OP/pwDbfL1fJ4Hc/DSuZF51aAM3XHjxaLRkwinYZu2RBi70a41j/iZ2Q8mZfJ
	 xGQg3GMzQJ4uYejrCqS1da3fs3cesh6fryPiJTbcP3qXgAgkWBPdtbnzLWexMws/JWu26
	 TJbMXt3SrLPS4aQCL6IZqs7UrMppQou4L7Zs6W9zIKHgvcr4p1UrVarKL1TJbWO+2Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=C+qR4cbO;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Vx1hpgvu;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6469660A2618
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 10:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6469660A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=C+qR4cbO;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Vx1hpgvu
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK7fDtJ3320735
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 10:36:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Jja5CIRJx6p71jdLiDhzh91wfoRIZk+1zpGerhUQBKg=; b=C+qR4cbOm4AQtRHv
	WIj1hFUNtydcyAh4E1CrmnryhpUuL4AyJrq1xnJKCD2K62S4iyMHxToMBgBiF2VE
	cMKQyljlLBoe25qhVfiafS6dGtz/SQtxJWRGOjuUfWOKxQM3XHx3QiK9RysI2K3z
	QO9BprVVJg/N5c0uqMjnats955ePDVr0XgCwh3Y3P7W3WHRbNb9IcDQDR+bRtUVX
	BKTUChVxVby3MCDRP9D+MUatUAS3OeIS2weqGYVeDYo/UaU6DscWfhN7D5CAvqpQ
	FFhYETFkKQLF2oGFa6k6fl7NJPjptAbY3g4bILgNC+KKOQVlng+WbSE2cQxOI0Rh
	ccLXdw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2frhsb03-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 10:36:04 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1b53bfc9534so149345c88.0
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 02:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795170954; x=1795775754; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jja5CIRJx6p71jdLiDhzh91wfoRIZk+1zpGerhUQBKg=;
        b=Vx1hpgvuomTMJOY9SULuWSAi2mwXr8hoMV2xmhwOgR91gj6YWXwEubZ9MW3Zaw1YaB
         z1/KncVCMkL6HAlniQ4IrE0KefUsKJJF0I9iRIzF8UsESqHAhEHo7ti1ao2Dq8ZYSJ24
         CnckAWUlhjDl2FCqkS53r/YnLrBaBH2HJtH0fFPafU56RFz2JiNEqMqUy3li1XhTi6RI
         UniHG7Ho4gzqfAig6x09WRaVddn3JUE2MNhOhGnXhiDMr2KOzDqXJ80iFnrE34VXpjb8
         2oeI8e7NB7BR9eYs0+ODkZw87tzgrCDxnfDeWPHzAuEUyTOmNek69i+q9XU8rVbQ6NyM
         1OtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795170954; x=1795775754;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jja5CIRJx6p71jdLiDhzh91wfoRIZk+1zpGerhUQBKg=;
        b=zeQfQ3+TTDlUIiIY/JrDc5aGMEXBVZT0p6IzK7WiKxy+RESki0E9w4OTq4jOHYcjQM
         KKWBmgnykH1ZDIEbnwVle6dMPeE8ERVzlzAjR9qoqKU4PE/YOGLjmk8ItFSDeRA7kwXn
         bDvjr+u5ZJDkmszxrMVOrRRStVzr0YbmWLLaVvFW3XBRi9j/ZnYXwC36ahLmKhUusy0K
         1vsKEezylHjSPwrYSH0oFPIoeDstsSz0MnhNzHmGKmjZkB1GzJUP19lUYb/FPdJtVEpd
         eVAXa4ap1O7U8TftmltvGdeGdFTg7/7cCrflat8JpuhyZc9d2mBEbHwkIotac03gBI3z
         dUsw==
X-Gm-Message-State: APuU4Z9knDkQAdS5P65fOZnCd37TUsITD2nlR6aY6Ggs/wtPKB8fnanu
	rn8j3IETCo39DuVypk339FCA1+YH26u7U53usYMdMwh+be0A2mvnEheaSKRYr3EsIzGjaI5bsgO
	mOaB2nQC5vyONw9tGSsG80wEgtpvH7h59FiBBjj7VrnVQihLETTI3a8Jglg==
X-Gm-Gg: AYBFou1WzU6IxL/4wWfgY11khXptA++muHg+XtPAZ1Y5cyFTESjnIVOcO7vYqesz8JG
	As1DYUTGkDKV4T6AVbcErgrOufbAo5+gm9JDIJksCWDD/EG83BTkM+Kdt8zhsUYy4zIx4yLG7c2
	/vTRz9gHTt9ko1sG3Oh19eUi3A+UcwIrpAMcDS88TkDJcxqz3vAtz/HYTKC2FD2GudI6mTXWJpO
	9OvE2DuyjI3oPLkwaKizNnAc1E/8WNHNwBaRVKlDaVChhr9Tgzkct7QYxITC6XULUvklll0Oj7p
	MWr0bfJiflRhJR/KhdPGSyHZYl67yxv5ct8csZkCzOtcapt1IgIPTta+97+ZeMIo4sYeoQDdxA4
	R8SMXhwSSp/LW5pNlCSCei9TkkYn7sre5sxydJFk1DEHYuL1apiuxvUolcII/Lng7IiYrnZNQvV
	awaZSeSBOL
X-Received: by 2002:a05:7022:f50f:b0:1ac:1022:b60c with SMTP id a92af1059eb24-1b5567b2091mr2086369c88.1.1795170953611;
        Fri, 20 Nov 2026 02:35:53 -0800 (PST)
X-Received: by 2002:a05:7022:f50f:b0:1ac:1022:b60c with SMTP id a92af1059eb24-1b5567b2091mr2086346c88.1.1795170953068;
        Fri, 20 Nov 2026 02:35:53 -0800 (PST)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567ffa8csm5751096c88.7.2026.11.20.02.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 02:35:52 -0800 (PST)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 16:05:13 +0530
Subject: [PATCH v8 1/4] iommu/dma: Keep reserved regions below the IOVA
 rbtree anchor
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-add_iommu_ranges-v8-1-d90486973b73@oss.qualcomm.com>
References: <20261120-add_iommu_ranges-v8-0-d90486973b73@oss.qualcomm.com>
In-Reply-To: <20261120-add_iommu_ranges-v8-0-d90486973b73@oss.qualcomm.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jpb@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>,
        Eric Auger <eric.auger@redhat.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Joerg Roedel <jroedel@suse.de>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Oza Pawandeep <quic_poza@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex@shazbot.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev, devicetree@vger.kernel.org,
        kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795170934; l=4536;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=FYE2mL+pZ5Z1CfQkgLuaMoSmZ66ItGzwlfYFBujy6n8=;
 b=WLCvoXP/7Vfbh6awPjv6raAWHYawo4b5pLRUUX7uVPAlECWCVMKQvpoW6AEbF6Hm2zyCDu7DU
 LNluQNoNeBJAST7P4pA6j6rBPw0mJ/JExYQhkjltmeKvmyAlZrCtoro
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0MiBTYWx0ZWRfX4zZhRSJiWfor
 ZM/Rm4jfaiWminK2zn118i5YQiTyAWV/+D3FDs7hPk4GPihwgqqmV4qLRsi6dzuEAV/p8FoTWrs
 rPDBgdxCZh+CSynXS/XOjwvVpBqf6G4=
X-Authority-Analysis: v=2.4 cv=d+9gWhjE c=1 sm=1 tr=0 ts=6b002294 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=EEemQ_ogMLg0kHTv6E8A:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: avz5Tbh8aC_Np2O7OhOohay4AlaSupxq
X-Proofpoint-ORIG-GUID: avz5Tbh8aC_Np2O7OhOohay4AlaSupxq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0MiBTYWx0ZWRfX8kL+fmOK7NCs
 aodZDVR1Vx0kXo8123A7p16gkRPibliPoksG8bVkwB4mrbHKrp2n9ErBR+H5pgeKoI1yxmwin0y
 CMuxM66aNsa+LkmUDTNbxWaefOkheq4VoWHZHCiBycSbsLG7+RmWtfgmOgWu9dHE0e2bBuYBWib
 mza5VW7w5uw3lBt4Lh61KqrUFpuP8hu7G74qnQJoY3PH9zXuGAodbDVEFV0V4Q4icuoXwXxp+et
 TAsWrThieueWG8SumoKrm4HPpsg0LCboTy8oqVRdPXQclxKH8kB7XPL+IMJEOJQWEZJgxiR4o90
 50jGhFe313rUinzxVY81lfM/TPckpBqHelQlf3u2B77lcBHfecDMBaqogtklSLFVeIlzrCN9Di+
 HzkqacbSr5qGuWuUikiHfVTEdrMJRmVrPgGZ4iNxGGIv9qoQSm+fhffUOHkdnNevl4dAssr5aP/
 L6by8E5bfiIeURppJiw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200042

The IOVA allocator tracks address ranges by page frame number (PFN).
The highest node in its rbtree is a fixed anchor at PFN ~0UL, which is
embedded in the DMA cookie. dma-iommu converts reserved regions to PFNs
with iova_pfn(), which returns unsigned long. On x86-32 with PAE,
addresses are 64-bit but unsigned long is 32-bit, so the upper bits of
the PFN are lost.
A reserved region that ends at the top of the address space then gets
the anchor's PFN. reserve_iova() merges it into the anchor and lowers
the anchor's pfn_lo. At teardown, free_iova_mem() no longer recognises
the anchor and frees it to iova_cache, which corrupts the slab. PCI host
bridge windows above 16TiB and the reservation after the last PCI DMA
window hit the same problem.
Compute the PFNs in u64. Skip ranges that start above the PFN space and
clamp the end one PFN below the anchor. The allocator never hands out
those IOVAs, so nothing is lost. On 64-bit, PFNs never reach ~0UL, so
nothing changes there.

Fixes: fade1ec055dc ("iommu/dma: Avoid PCI host bridge windows")
Fixes: 7c1b058c8b5a ("iommu/dma: Handle IOMMU API reserved regions")
Fixes: aadad097cd46 ("iommu/dma: Reserve IOVA for PCIe inaccessible DMA address")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-195658@kernel.org/
Cc: stable@vger.kernel.org
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 drivers/iommu/dma-iommu.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index b66e83cfbc5f195a46d286d376068fcc13148611..2ee30df470730fd03b5dc46b46e3eaba2df130d6 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -505,21 +505,34 @@ static int iommu_dma_ranges_sort(void *priv, const struct list_head *a,
 	return res_a->res->start > res_b->res->start;
 }
 
+/*
+ * IOVA PFNs are unsigned long, and ~0UL is the rbtree anchor. On 32-bit
+ * with a 64-bit dma_addr_t, iova_pfn() would truncate the range. Compute
+ * the PFNs in u64 instead, skip a range that starts beyond the PFN space
+ * and clamp its end below the anchor. Such IOVAs cannot be allocated.
+ */
+static void iova_reserve_range(struct iova_domain *iovad, u64 start, u64 end)
+{
+	u64 lo = start >> iova_shift(iovad);
+	u64 hi = end >> iova_shift(iovad);
+
+	if (lo < ULONG_MAX)
+		reserve_iova(iovad, lo, min(hi, ULONG_MAX - 1));
+}
+
 static int iova_reserve_pci_windows(struct pci_dev *dev,
 		struct iova_domain *iovad)
 {
 	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
 	struct resource_entry *window;
-	unsigned long lo, hi;
 	phys_addr_t start = 0, end;
 
 	resource_list_for_each_entry(window, &bridge->windows) {
 		if (resource_type(window->res) != IORESOURCE_MEM)
 			continue;
 
-		lo = iova_pfn(iovad, window->res->start - window->offset);
-		hi = iova_pfn(iovad, window->res->end - window->offset);
-		reserve_iova(iovad, lo, hi);
+		iova_reserve_range(iovad, window->res->start - window->offset,
+				   window->res->end - window->offset);
 	}
 
 	/* Get reserved DMA windows from host bridge */
@@ -528,9 +541,7 @@ static int iova_reserve_pci_windows(struct pci_dev *dev,
 		end = window->res->start - window->offset;
 resv_iova:
 		if (end > start) {
-			lo = iova_pfn(iovad, start);
-			hi = iova_pfn(iovad, end);
-			reserve_iova(iovad, lo, hi);
+			iova_reserve_range(iovad, start, end);
 		} else if (end < start) {
 			/* DMA ranges should be non-overlapping */
 			dev_err(&dev->dev,
@@ -568,15 +579,12 @@ static int iova_reserve_iommu_regions(struct device *dev,
 
 	iommu_get_resv_regions(dev, &resv_regions);
 	list_for_each_entry(region, &resv_regions, list) {
-		unsigned long lo, hi;
-
 		/* We ARE the software that manages these! */
 		if (region->type == IOMMU_RESV_SW_MSI)
 			continue;
 
-		lo = iova_pfn(iovad, region->start);
-		hi = iova_pfn(iovad, region->start + region->length - 1);
-		reserve_iova(iovad, lo, hi);
+		iova_reserve_range(iovad, region->start,
+				   region->start + region->length - 1);
 
 		if (region->type == IOMMU_RESV_MSI)
 			ret = cookie_init_hw_msi_region(cookie, region->start,

-- 
2.34.1

