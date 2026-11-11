Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794402185;
	b=2Rt9bUT2rLGqt5gyPVlkrOeTWoFjsWv13KbauzChOoZHXpaC7tHQRhmsBoCqyVijPNgf
	 jgqZt47e3F68sISAL23F3S5IW/6cRD+ZmuQYoSA/kSgkfB3jA2GTCO/e6tgZleOWzWkSq
	 nn4VJUIFYyb/PJbHZueDH83u8CAnNrW5ZzHjw2x8GGZZKtwDmMp65Fm+wz9H290hiGeQN
	 HXvk3FnRQGor5nXknUHQ0H4g6qyNFX+Eb7P5zjNbNLyERpcu2DJP+vBRAf+KuVuvxn61H
	 pZPOuxqNoMwC55z651aRNFlitUtrF2Jnahb1YUPL+F02RDVMG2TyRy+8jbFhRFcA+tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794402185;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=L8WR9+GG2EfUF3UrFaA4c5ksUoCcRyLK8GiwEhxkvFI=;
	b=ik9dv4pXtkbnwE4QnQw7PsvUqHn/WbJzv8mHBMLiYwhlU4BxVmH/YfK798rEoTxCkgTr
	 tcpwSO0663o96LiQM2zyqYTF6eo0NhQZA5kPbKd60aRDAt91/NC5oHrqxOzjd35pRpDch
	 5B4BgnLEEyVaVgehKPW9dsOWhpDZkprtTTAC9TsTszd82aREerYR9PUJVHefduGD17cHe
	 1AJGmvzjfu2qOOriIrO8x1l3Dd7qK5238ZMgnS6XahjkNPhyesrf4S6M1fNMl7d2iyy+P
	 NQl8RgaM4qWIN/DN9fQyeOunsnD5g67SSmCjVFx3M51q9ZyJY/LWM6NyITiY6r0hQZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PH9mWwXg;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KuqIuizb;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CABC606A324
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 13:03:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CABC606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PH9mWwXg;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KuqIuizb
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABCZ29a1806843
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 13:03:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=L8WR9+GG2EfUF3UrFaA4c5ks
	UoCcRyLK8GiwEhxkvFI=; b=PH9mWwXgQ5gEnifkFQhZ3anQH+M6DXWxjaYRNBm4
	8z/pNaY5400bAsBEpQNm+vBW+Q+jfqxxN8HzrTI5OzBHGZzkIlvScO/QKa7SGl2a
	PcypMhUu/gBKUX5uX9oh04q9yOC77RcAXm6BOFLzWoUXUVzVzcsM5EsBVKTYRsaf
	ij+ZkoP+ccbshZD5IvbBTtE8sEoCZpbwWmu4e2y+FeoOw8o2qNPB3O+GvjrxE3+p
	AL5/WPO/FeuqH2XP24+LiL3cpFAdsvCWMFBzD9x9fNyI2UQVztZgs07w1ZKgjDrL
	0O5WFB1GTvFsJB+TEYBpy6tRV1lwTog6SnR/2XN3l1argg==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvfawj7kj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 13:03:04 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5eac74b0596so2648675e0c.3
        for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 05:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794402184; x=1795006984; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L8WR9+GG2EfUF3UrFaA4c5ksUoCcRyLK8GiwEhxkvFI=;
        b=KuqIuizbmCd0rTuMSD+m7DGeNFrCd5efFRc8GEEQYUEkUCfYIL0P2L/YWXYZ4gcNTB
         +mBEHLJQ/Dg/l2At0D/V7ubcZVf7eJyUKSJo4eKUFyHb/ptqn5kYx/rdaJcO4fsmOwSZ
         rvkCU9uhlnRIfi5mGl9CQLyri+dkn+C2DSFX2NHeb4CejPTlUFtcmR47BZ0Izxaz+wxC
         FGooUIvYSLqNp1FFki7xP4z4oq/WGlQYyvgtsVm1lSfqCPHgk99LM+LulpISXEc75heW
         utS5tpncSurd2GloPl+TLrP3CGNrWWCldMPhy211uUiCtBSTEc6zCEV97g/bzOKk1mwT
         JT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794402184; x=1795006984;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L8WR9+GG2EfUF3UrFaA4c5ksUoCcRyLK8GiwEhxkvFI=;
        b=bUvXNuRHUjLsKWElsucgPUZVDTMiCP47+Bopru8MrD8sHAap0iVBJ7lIko4YPoV5VK
         oovp9SpME76njEVRh7rlVQdVdAGKafiO3Nw5VKy3XdbiT8AAy5joginoOWbKakh6Kp7I
         /1slJIZE8q1cohYMkK/BNXiLiLeaLiNMXxNpqeEBr50jUysbmcXaBU04DT1NTBwF9O0M
         o2GmfciDwH/lOFa9wgFCxUTS9xT0403HOr4rYKtmjB8n5p1PQxXf9rkp9yUgyKYfQ/29
         l1Hf2vLGzGg1r7EjV22Vo1KNrJhXOz+5J0x1inlkh+ENL1cvjiPPVHTwEhE5Q8j/5EUL
         6mLQ==
X-Forwarded-Encrypted: i=1; AL+hErEkxUg6alGNZlV8k8ixNas0+vEj/UFh9klQX9NXkW3mCwXrW4mIfHaKGfFBK2zUbHmsY0ookg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/jncTTSFag+Bzdg99Ld2LQzEKRg0Wlmk67XVRw31sI+aSvyc0e
	AZ+xb5jkIyXe8PgaRA4P+lS+/QpTLzc80HS6zMKrw9UKSZAHlPTlW/DwILZdVf61vDzuvHhFOup
	efakNmgDi1wO6N/7l6zsYFw0RhpFAV2NSSGWZtCavAqcu6Teq+uvXpn2RMQ==
X-Gm-Gg: AYBFou04TIIXfbTzxOGDOvMfVQIxVIy3cilDrJLRBE6wBdbsF2lQAqTgfsXh64mwALO
	JJ+5rvzMbsz9FZBSZNUck/jqRwaFOB6F44xvLe99dQyC0vdiQPbCY00vKGbF3h4I6qJZNOBEMdu
	c4110GyfZ0EV+iIRfZvSFuaJuWnLjWgsVDS+sexet90h3ZcxYVBB73i4Ed5/5IkabM1K+uWDEaK
	9N6TQJ2VIO++Udc3oJCfqeZAOUrCfiZ3AFUKK8S9kC21BNg0jrXD8ORbr3x/QQ4LW0pI2q1Eibr
	trQgqjnpmymcmvDRE2pgxd6ix8sgOZiowOajtbDQAZ8XbXFk/lNVBe9Kd243qbYY9QqbQoWFeAW
	GbpPmQPqufLxWjDKZ4xSKPg/2dU9ebkjvSC0huGZ/LI+M78W5KXzAZwTP3cexCIqJQlML5+S7wZ
	FQp0/Rvwp3hk0rhDNOu3ltwLCETKrDT1qrIyopDtR05COcRvTaGd3pBiRpihbsng==
X-Received: by 2002:a05:6122:1782:b0:5c9:a7af:8178 with SMTP id 71dfb90a1353d-5ee1c2b2435mr795034e0c.2.1794402183586;
        Wed, 11 Nov 2026 05:03:03 -0800 (PST)
X-Received: by 2002:a05:6122:1782:b0:5c9:a7af:8178 with SMTP id 71dfb90a1353d-5ee1c2b2435mr795003e0c.2.1794402183114;
        Wed, 11 Nov 2026 05:03:03 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c157bafba6sm959941e87.62.2026.11.11.05.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 05:03:02 -0800 (PST)
Date: Wed, 11 Nov 2026 15:03:00 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>,
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
        Alex Williamson <alex@shazbot.org>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
        devicetree@vger.kernel.org, kvm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: Re: [PATCH v7 1/5] iommu/dma: Keep reserved regions below the IOVA
 rbtree anchor
Message-ID: <5pyhbuzlrk2pf3sct7zopoycvgliuvzzmd5qse65p3r63jarvo@g3clac2ao4xq>
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
 <20261106-add_iommu_ranges-v7-1-5c0f72083e52@oss.qualcomm.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106-add_iommu_ranges-v7-1-5c0f72083e52@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1MSBTYWx0ZWRfXx2ZEV5qBOY/1
 jRCUr65qSlTfSZk/BsvnK4cdIL2wzufNkVwYMK5oWOcvyoziZJeaAxVVKLiVzlO421mGpXLeF0C
 bU0odAYim9H6xOry9yAID/TJcwLyxEI=
X-Proofpoint-ORIG-GUID: HLtFksCNdyhzhs9b6Ll_cs-T1ckPaWoW
X-Proofpoint-GUID: HLtFksCNdyhzhs9b6Ll_cs-T1ckPaWoW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1MSBTYWx0ZWRfXyUYLMY3Hzgkt
 0sVow8UMteTdBjlBLRKe3qiF6UI2d77zE9HzHZ5yqAha9Q1Cxy/swPX8/kwzXPCIciyC+4r8KeM
 9rn7zs0wgxsHc2ymL1H64NHM2ujq6zshe7W/lDQgSITYO0yLoAv2vg3KtfXXeGg2ghwHqnlXL1b
 BEopQ+w9+TlRrQU+Zs1u8LN73wyoRbT92LifmX2J4a3p1xpmGNrBA1C/f8bjC0nkrxSNKv3ZWGv
 WfyvQWRGY702JRJS3F7NTG4gZ9lrf9tGnAbaLSfzEmjxf4aXaigMaaWab+T45WecgRsAl6/++9/
 V/qX1sOBoIwrb7jRNclhMpVmowgGFDlwGXaeoipKuSGC+QxbzYMaO5PsS10X/6LHrbYka6lBvyn
 Mj7uFtfR4JMqjwLNTrJfdHIQBJUekyLEnb1HvNAh4t6WSuwYEKrUyYKaX9UX88rNe6aK69XgRm4
 VDSeN9+iCXx31WI1KEw==
X-Authority-Analysis: v=2.4 cv=CZadd7rl c=1 sm=1 tr=0 ts=6af46788 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=WA2_6xBGtpbLEjlkeFEA:9 a=CjuIK1q_8ugA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110051

On Fri, Nov 06, 2026 at 10:44:24PM +0530, Vikash Garodia wrote:
> The IOVA allocator tracks address ranges by page frame number (PFN).
> The highest node in its rbtree is a fixed anchor at PFN ~0UL, which is
> embedded in the DMA cookie. dma-iommu converts reserved regions to PFNs
> with iova_pfn(), which returns unsigned long. On x86-32 with PAE,
> addresses are 64-bit but unsigned long is 32-bit, so the upper bits of
> the PFN are lost.
> A reserved region that ends at the top of the address space then gets
> the anchor's PFN. reserve_iova() merges it into the anchor and lowers
> the anchor's pfn_lo. At teardown, free_iova_mem() no longer recognises
> the anchor and frees it to iova_cache, which corrupts the slab. PCI host
> bridge windows above 16TiB and the reservation after the last PCI DMA
> window hit the same problem.
> Compute the PFNs in u64. Skip ranges that start above the PFN space and
> clamp the end one PFN below the anchor. The allocator never hands out
> those IOVAs, so nothing is lost. On 64-bit, PFNs never reach ~0UL, so
> nothing changes there.
> 
> Fixes: fade1ec055dc ("iommu/dma: Avoid PCI host bridge windows")
> Fixes: 7c1b058c8b5a ("iommu/dma: Handle IOMMU API reserved regions")
> Fixes: aadad097cd46 ("iommu/dma: Reserve IOVA for PCIe inaccessible DMA address")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-195658@kernel.org/
> Cc: stable@vger.kernel.org
> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>  drivers/iommu/dma-iommu.c | 32 ++++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 12 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
