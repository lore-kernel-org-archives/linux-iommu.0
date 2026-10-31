Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793478816;
	b=xwDelihNSa0Wc0mcdgLccSEEKNAzBIfpnpmuUdoWPJMsV2Je9sJvf4M7F7C6MvM/FRXq
	 3GorNLds1QPzrP5Zv9peP8IV63rrJjvKo74GyyujpRCMBm0mIoXVcMq9zEBGSYbB2803Y
	 sTGWvlGUKNAlEddetkb20lxvL2UEfoDYs0YPYvX7X4Q+WyPdsArJFhcIaG8vUBWgjJUWk
	 jco8BySmDHuDW5RBBPfKeheBn/ZgwRRBjI579ysydGGR5yGXn/p8gtDWDIJrk1RJKKDAP
	 tGArXqO25zO2sqi40zw4y9bgNJCAZIfeYdnxUZxROhkTRo3WSDIw+lp94vd46XUEnEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793478816;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=kTuh3fPFQE+RsK1pP0e5pRuUCh3v0uJMIAOGrhkCOHY=;
	b=op7RSCFupr7xE7B2GRmCAC64Bv/H/Unj1g6hhjCwYCosa948wihPPThXziyqJ+Bz12ub
	 mmgzf635dhOPpmsFnKP/UYVp6a8OFw+I2wpRItRo4zC40TfZzdW72+g1Y37CnpgQHvzxf
	 P4j3Pr1v5y4qMdIqyqP8Ap3/9DSZIpKs38MVPU5WxK4zy+qXv6EhhTe/9qAxmDUfiOjVU
	 sieRRwTgITm8UltKHQIRTZo7LBuUnzudBguQOnCzW9Xp2A/lBIl/nIYrGkDjJu4H5xOmi
	 6sYTSmYS4zVqC+VZ02ZpTbrBgfiADd0YZcsEr3D7r/5DbJcv4gmR1socGZIqz6Dmd0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=pcJ76rFt;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=j0FHCqfM;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CA0606A33C
	for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 20:33:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30CA0606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=pcJ76rFt;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=j0FHCqfM
Received: from pps.filterd (m0167072.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69VDnfsk3269781
	for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 16:33:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=kTuh
	3fPFQE+RsK1pP0e5pRuUCh3v0uJMIAOGrhkCOHY=; b=pcJ76rFtxFkJVl+ONgPe
	beDCMsOuIG4HcFtOofrRFNr000uYINp6Zv0oIrEjeBxJa1c9aJvqmDKj3wINJFrD
	lJkAx7rbIAI+Ffsha44cGmFB8y+jNylXBqeqtY6mb+AgH8OOck7h0tGd0Cwjj84r
	n71MjNZRAbGe6yoGyG2r7tvYgvIRhAJhUKlWFy2feEq5ay+A74pGIZGdqrS2aQpZ
	aN15HM3qpGjNOiAljxtRGpIEExViQvg2Pwyuqw8/hlCB42NTc/2fWDKXplt5dnUh
	BljkAZVXitn75HnYmUxf5j1oEbxYgAvUk/xTUsoJwuP5VDT4QICI/U33CKadK1i1
	ng==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4hncgqb520-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 16:33:35 -0400 (EDT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91c75523074so37071876d6.0
        for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 13:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793478814; x=1794083614; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kTuh3fPFQE+RsK1pP0e5pRuUCh3v0uJMIAOGrhkCOHY=;
        b=j0FHCqfMvEh4Y9QFyAxkLm0NuIEs4q2fg+eP3UN9iwdXJwFMyD1T8m5A/5bBdN72+P
         3Q4m/mvQ+wdgOSGmqGzpNpakc8+JAEekMDxkfehYH6jdIiMUeZWAA4H9pfxXk9jcZbVS
         X7iGN8lYTtiGnJs7gOv5pCsm44BKmkAIoJlM+SJSu6ro2PZ+VhnFw6m9ll4rv/jfH/LU
         dcLhXXBB1buR1eH34Nz0i3yO4o0B7vw44yRrNkzDWF7ikCVDkxwDEvy4+MsMKxqCcM5S
         Uo25g/7PEkScmv1dvNvxjCUpJ1pCTeBOI6oO1RVN/B+kRNVElF5+GCW9Yy1yReQ1t725
         DLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793478814; x=1794083614;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kTuh3fPFQE+RsK1pP0e5pRuUCh3v0uJMIAOGrhkCOHY=;
        b=i3uSbpVx7VuO2FOigT2PzP7WugywPpez7vjJTOzaLFjdn113PJ1mm+V8dIqIHngojw
         k70zqNS3hmgQQg0qwhn+NPz1WM327SzwFP13nyDXo63+VQV5zG8vvI1ZG5NkxeG07dlQ
         EF57mjqMUcK9cBKULhG6iO/22D2GeyaKJV+1I951wIiYRsUSJw3C7dPZVYBWZQK90dqL
         9YKkExeP4eiUvF+fuM6IUsQsGjPJewNq0qsGvfM4FLAc71afVn6seFdXlsy4v73yARCX
         JbERy1WxiamiQP8SOH1JWix2cla07RGMOE88lsldGqaD4zXxScruAYIzId5F9aSg9XLZ
         ReaQ==
X-Gm-Message-State: AFq9FYIHiBr0GcWv/Ib7vYLkkScPq8iiQNEv7BQXSZeFzx6Kb2WW4PfR
	vFoYHK6u3eVLMcisVBJk15wxQv3mU4VHKNGliXLlLvYWH4UfFdSPOsRC+gbUAIT4FXbwVbkBBK4
	pw5GKG4ttWWORdouAzug/++p+xWAM+dgnl49hW/SLIAh6RyywMxem
X-Gm-Gg: AYBFou0W3u2jF3m4dAY4qjrg/5B7C93cbcm+IAfCuFheD5k7GLTQKWCEQRVOcZW2WqX
	rArxFet85/XLr4Fpvi7WrX4e2EKSY3crMg+GK58ZzamaUyz5qPZ5rrdHPHL3bn7FNrPSC3XYIYh
	g4hpqMIAL5w2FNvqWVEFxillSRoOVBQf9a/0Y9A38lGpz9VBUVR2PyhD74wYot7uI4LtXIyo2Au
	2x8p/TjXtpRJqmPNw3Y9eren5UeswdgzqLP7W77VeKUs40HuxG0LHsjcarvEqXLl5mhA3NIlFjE
	mFoCcgMJa3XWwt1i9Mruy6S4oQyvoe2aaVAmTF0L0pSoQ60fpkbISBm5ZU+mvZAFO09U8cuXev9
	AiMqyzSalnnNFFB3v7fHuz25jYXraimCAZixO75OfCCzrzUN6l29EGvpv0CI=
X-Received: by 2002:a05:620a:2686:b0:93e:9292:1b9e with SMTP id af79cd13be357-944215817c1mr877318185a.1.1793478814341;
        Sat, 31 Oct 2026 13:33:34 -0700 (PDT)
X-Received: by 2002:a05:620a:2686:b0:93e:9292:1b9e with SMTP id af79cd13be357-944215817c1mr877315985a.1.1793478813823;
        Sat, 31 Oct 2026 13:33:33 -0700 (PDT)
Received: from [127.0.1.1] ([37.142.155.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b81c74sm10019650f8f.36.2026.10.31.13.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 13:33:32 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Sat, 31 Oct 2026 16:33:18 -0400
Subject: [PATCH 1/2] iommu: free dev->iommu when iommu_fwspec_init() cannot
 allocate the fwspec
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
Message-Id: <20261031-iommufd-folio-dirty-v1-1-2cef66d2d6d1@columbia.edu>
References: <20261031-iommufd-folio-dirty-v1-0-2cef66d2d6d1@columbia.edu>
In-Reply-To: <20261031-iommufd-folio-dirty-v1-0-2cef66d2d6d1@columbia.edu>
To: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Philippe Brucker <jpb@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793478807; l=1832;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=GYzaNKZE2bNcDpg5+Vf3PfGs+rkfapFAcXrezSUB6t4=;
 b=juLcHRoT+rfjskMczM+EFC1pZ9p+jeQ6Vz0Z3+flSqZR9iJwTZebhtMbbO5UmciybEuKSWMBn
 bx/g0/aKysrCQMwpY/Mrl6sCychBCjaG545kIpAa9PBEm/7YPzZyfKa
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: -djDLF1BqtmJaFTl8IC4MSUn8cD_bbM6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA4MSBTYWx0ZWRfX2TVXhnwLNALN
 7qis+NWcmi9lsR8t6UbJM3+otjCW7WIuOjJMSlGvfZ40RWLtfTuoQSVdV2U+iRwl0B0u1mz0LJL
 CQR3j5XxcK0IVQt9Ic+vLo/opIBOQ+9ceEGhqblRbgOMBpAMMp4w19www9/+F9JB8/Bq8j14wua
 t9HYmA7Xu5IyeQPbP/vZ3bdMc19uvhBviXjXWyH1HD3FaSn77gdn4xNz1gYtVVCpqFNt7eswwiO
 gByK7zk1mNimPp+UP0CXWORfgLYkhr+177qIul0CbeOTLxGvqhWeqnYH4UmG+t3rzuc1dSRVX8p
 UYm2G9EPfFqOF9ZLsZICmwxM92l5DalOIdMFaJn2l06xzO7JYkYDGQ7wE+KaW51TMDe7ottSXia
 RplS3FpKZO3dX2EplM8CT/UFCkgGYN2sbnHWqZy2cPNgz4Dl5HRGj0ZDi3f2kRxRZmczmRJ1kK/
 iXxFh7d8lGkEuHL0nDg==
X-Proofpoint-GUID: -djDLF1BqtmJaFTl8IC4MSUn8cD_bbM6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA4MSBTYWx0ZWRfX/XZdYpYRjJxj
 2mo9pKXvY2KG8QnmPPWlvlbS1/pGjTdlbn77YHN1+Rx04dhuECY8OPQsTBSRfWDbjZuajE+dQ63
 4uAyqPyeLO2TFtcpZxhTxqnoCDY78mkf52QSEA6H90KuIHtSilwG
X-Authority-Analysis: v=2.4 cv=ZIpCCn7b c=1 sm=1 tr=0 ts=6ae6509f cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=OyQKmhT2Qqi7aVZxTY5mBQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=SsB-OO3BMngHh3ZO9fOt:22
 a=_oc4-Chm3xCJoojDiZIA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11952
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 clxscore=1015 adultscore=0
 malwarescore=0 bulkscore=10 impostorscore=10 suspectscore=0
 lowpriorityscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2610310081

iommu_fwspec_init() allocates dev->iommu with dev_iommu_get() and then
the fwspec. If the fwspec allocation fails it returns -ENOMEM but leaves
dev->iommu allocated, and it leaks.

kmemleak reports it when iommufd_fail_nth injects the allocation
failure:

  unreferenced object 0xffff88811c138b00 (size 192):
    comm "iommufd_fail_nt", pid 783
    backtrace:
      __kmalloc_cache_noprof
      dev_iommu_get
      iommu_fwspec_init
      iommu_mock_device_add
      iommufd_test
      iommufd_fops_ioctl

Free dev->iommu on failure if this call allocated it. iommu_init_device()
allocates it before calling into the driver and frees it on its own
error path, so leave it alone in that case.

Fixes: 72acd9df18f1 ("iommu: Move iommu_fwspec to struct dev_iommu")
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 drivers/iommu/iommu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index cd1bca7ede9a..69be8819e05d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3074,6 +3074,7 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode)
 {
 	const struct iommu_device *iommu = iommu_from_fwnode(iommu_fwnode);
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	bool new_iommu = !dev->iommu;
 
 	if (!iommu)
 		return driver_deferred_probe_check_state(dev);
@@ -3088,8 +3089,11 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode)
 
 	/* Preallocate for the overwhelmingly common case of 1 ID */
 	fwspec = kzalloc_flex(*fwspec, ids, 1);
-	if (!fwspec)
+	if (!fwspec) {
+		if (new_iommu)
+			dev_iommu_free(dev);
 		return -ENOMEM;
+	}
 
 	fwnode_handle_get(iommu_fwnode);
 	fwspec->iommu_fwnode = iommu_fwnode;

-- 
2.39.5

