Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794395112;
	b=gsAXGO9xN1jcUK065D8yY0IeSwterUhs52TYoM7UN822j7L7xCteEXhjMwEmREpoNLor
	 aIa2Kc3q+CQKSQwAZIc6qIrz0gLmlpjRXpJMr9aDlCjsTb26+Jgdn4Txm7J5Kz9oTQfiQ
	 aAb7mi8HcJs/Ljv/Ag8lEVA5Z8V2UDvZJ3QQ9HprmJIznsGEOUxzyHAZeIBdA7t1si+rE
	 /om2LfbpAdstU4VI3ftxDwCrsUcxsjSoptVrfbCCzlyWfZOvLqpGy0lPk4lz/5xWD+3rw
	 /2LQQJfmOqqL97vUA0Gyw9917T8GCM4B84eVy4OBaWe9taBUIOsCpYYIAfZeWNtLMmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794395112;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=aWDnnNx26bu9eNBEE5EhcsojfHfv5oN9+T/oze9PJL4=;
	b=L8IHuKEM9AqkxC25Ufg+0YfTFtGmmaZntFWjVZ7ZPjt9ESCnE60qZzd81lGQbh5iPftV
	 LoBto8bqH8csIVOaVtLoOzplC6NiDUUr13b7vGENLn7iKK/ik+uQuXZ/1jQKY8C7RQgcd
	 w4jQuAuJ35T34DHkIdtsWPwO4S69Z73EkAtEjlbRDbizH53yGwFRX6AUiPy9s6WlNYY59
	 8hITqcIPBic1+BfzuzbDpm7wQehEQFN1/vZFsNwNA1bTEwli9IMC3KqD5gcnJrVnhQZ64
	 g+jvyinoK2gd2Ukb2YcHvdFJ5Laq12G9YCIwFJeN/a3Wwa2WFUpomuU37qrPnYyWmFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mz7BvnsU;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jL3lApD0;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E439606A326
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 11:05:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E439606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mz7BvnsU;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jL3lApD0
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABAr3Lw3959068
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 11:05:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=aWDnnNx26bu9eNBEE5Ehcsoj
	fHfv5oN9+T/oze9PJL4=; b=mz7BvnsUk9uvZQBPrlrCP0FY0EpKMK8Fnk/BJHJZ
	eIoz6x8b3e5HhK20kdOqW2ekkFFf4tIzIIQd5SEedf5uMjSOn1lfN3HMweVk6lH5
	ntz+LJKj1xA3zC1lWMiPjWdkI7P4ItEVdW191lQ5ipmefuyWEOahTrGjWcSdxLuU
	6o+wZx4H6jlX5sycKyAHYbwEDsNvpGFbhB0YgljGlpALYPGUt4AeZiDZLjWRE7EO
	9Vv4M/xETI0XHrHJGE+QWvWV4JiSzyR+bb63NyL/COQ00bTFpK9FUgmvXY0PAZvi
	blXIaVCaAkAuxykk5ieBxYSJL7zNSqx6hLI4vaa2D1tpzA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv9b337wm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 11:05:10 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3724667bc16so532660eec.1
        for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 03:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794395110; x=1794999910; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aWDnnNx26bu9eNBEE5EhcsojfHfv5oN9+T/oze9PJL4=;
        b=jL3lApD0uyJ1xeB5oYKw2wIcXni52E406bRDMhrwqo9E4F7wtRkIjSqc2T3HgkAUzk
         b/vBsku4PA0oYOdHcGL/lg9lmCjDqm60bwa81Qnu8KwmmzKJ5ABFqKMc6DXOjh2bpGRv
         jan58CKAY+wH3ia0fuqszw1PBAASgughX4PAmgpoHMhfrbzc/BloXCiVBzaZbaa7o4tK
         zaWfMwsLYrfNlgfVGtDha6Z4fT0x8lSNMI7686TMrX0qYbIIvlRZs/2yeRK4GnEdKy9y
         Fl96lOSsVpbpl+yCZO+HGmih+EJjHkfReJYc2hH7TY0k7J3aU8imnrcZ9FO/Dp6ygUuB
         Nn/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794395110; x=1794999910;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aWDnnNx26bu9eNBEE5EhcsojfHfv5oN9+T/oze9PJL4=;
        b=sGQtyh0Ju1rhiFiMndrzJX1pAbb3xArmtzWnxfNOJkQs2qsoCBcXLnyE9HJjvLonxz
         IogYZ42IWVFcgmBfHok1irWRufVyvbM8Mb1zNihXV0ytGN5MXrbcV8Fh1gLw6AIB69mN
         LSYG/IQrfYDe+2FB2t/lLlLwdY6/0qwHoRC9pStkHoDCowz7tDHykEVP+1uFJN0qtRAC
         RpR+UtLzJ0PcfDJJRIktKEZYMOwXHARuHaAB3KEfiZLWT7fyofAlh3Sgq9WQ+2BGB6cY
         6rhuIdNeX2/8oJtLLrlxqSdhgqzHjV2aZrPdbbzKcJ/50lLZJPYwSF9AByRKOQEnVelF
         2v7w==
X-Forwarded-Encrypted: i=1; AL+hErGIny61/WuFY+1ylQe4xCR2PZX5KYUh49QCuTz3HXvPrwZ1Wz2bnxZ6oYvmvSAlgYlGthG7mA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9P5HJA6Pw4Q+HteLH3yY91KzwAchBrLb4tppM0Y+QNM3l/3YWX
	ST17VDvSZjSeZG+TzlEhjfYP5iVQlB8LM8Q9emAf8NsJsU4Djn3Wt0g++OVV6fethIQyo/mU51y
	7E1aFL+sVFE1YHxHenhJU5rq7ASJ447iS661NRPTYLieZsgJvNhWWPGcmDA==
X-Gm-Gg: AYBFou1YIIJirKMcxrziioBV7g/Cm7T2VyHO4T4T6FZUHDHwCSX/G1a+PFfLuUsMbEy
	6BCm8QOR8FWMpiqPHFNOGAaA7V5HTw8Ih5tuURn9B5k2mM2ChPeEI9iKvvUiVPRqhHwC2YV6DNN
	NYjZqIdAfQ/d6yPLwCREPCNZH8/zdk16XMjOfrgkhefPSUH4dZmp7jyALxzt+h8xJy53MwgEXzk
	xvo8UYXg3f/cEJd+OgzDIAtLGzD21rtn9mjmUgDAX74maS/ZXo0enuQAxqgmNZYqV0ph8Yom8VA
	Ws0yWmjLO+9WyMtS2le8RoQ+zVS3blkb6X04BcRD6NHsuJuHGzxfmO0LyeThJEblNAdolFWxbSY
	xo5xkcN00Sikwd6naL4Dwc31gwh+u7++hUC0ezxfBOPU83H55jDn8lx4PxhQXH0B0g+Bqqd+gQ4
	pL65tNJVQ=
X-Received: by 2002:a05:693c:6391:10b0:376:c208:ed7a with SMTP id 5a478bee46e88-376c208ef25mr1678188eec.8.1794395109942;
        Wed, 11 Nov 2026 03:05:09 -0800 (PST)
X-Received: by 2002:a05:693c:6391:10b0:376:c208:ed7a with SMTP id 5a478bee46e88-376c208ef25mr1678128eec.8.1794395109019;
        Wed, 11 Nov 2026 03:05:09 -0800 (PST)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520608b52sm13502136eec.13.2026.11.11.03.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 03:05:08 -0800 (PST)
Date: Wed, 11 Nov 2026 16:34:56 +0530
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
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
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Subject: Re: [PATCH v7 0/5] of_iommu: add support for "iommu-ranges"
Message-ID: <avRL2AeIXEpA8SE/@hu-vkatoch-hyd.qualcomm.com>
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
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
In-Reply-To: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=GKGdgeNK c=1 sm=1 tr=0 ts=6af44be6 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=DzlgiSjgYWYhIfnXaHkA:9
 a=CjuIK1q_8ugA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA0NCBTYWx0ZWRfXw0twCPwCn/MJ
 H39Fi2TzeqJ5brmdIrZXfEj1Vrg0kdwX+t52j7DrfaWf9qXRD60YnTPzpH/CLf3XaEPCppmVYtQ
 i1jnW+cwHYkLdfyKxW183657UFR469hCDsXR6x4C421TrYE4CAWnmbEVfLZ67miFZ0BF8on0W6b
 Djp9uAmsLFQVAO5BZjGbGNayaDo6hQc+6nAEI/3b9V++K/O3i5tBeWKJY4i71KX8CJ8m7ZNJ2JW
 9Ka6T6Yq4CE1N4pHxDlAAClKi99ozMFo8Df0xo2JT9ZqpYr4fFygUjewKSQyQqzah317Ds3We4z
 HhNDu5DJeeCt1RyzxtIrTl2ozbiNbVSlMahAalDuJl1F31H4aiWw/9ue6IaqUIl7V1rrESVfTFZ
 c3v1g07o6Vu9XyxpIN99eJVu9ihEoH/g9PZuBvngSk2ccjhjvN/ORmz7+IVX9nyBoLeLQdsJ05r
 SvPxWKIc4x+LZBc5adA==
X-Proofpoint-GUID: 2wAEmoQlmUtZSp6rekE4_v5087Km6UfB
X-Proofpoint-ORIG-GUID: 2wAEmoQlmUtZSp6rekE4_v5087Km6UfB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA0NCBTYWx0ZWRfX74nYRC4pSkhS
 GU4X4kmubQLCxpzarxzicri8gabZb8gw/2WfznxjcJS5eXHuZyvlOHn1XPa4THaJqCSF0gUYg0j
 Biwx/bqmuPxJtaOi2sHz+J5zzj7QlNY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 lowpriorityscore=0 priorityscore=1501 phishscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110044

On Fri, Nov 06, 2026 at 10:44:23PM +0530, Vikash Garodia wrote:
> The series adds support for recently introduced property 
> "iommu-ranges". It adds the required checks to error out for cases 
> which are not following the schema definition.
> 
> Iommu-ranges was defined in schema with this PR
> https://github.com/devicetree-org/dt-schema/pull/207
> 
> The patch series is being posted as revision v6, since the patches 
> were initially part of the media series [1]. The patches are moved out 
> to get review comments from iommu reviewers, which was otherwise looking 
> as a media series. Happy to move this back to media series if anyone have 
> any concerns. 
> [1] 
> https://lore.kernel.org/linux-media/20260926-vpu_iommu_iova_handling-v5-0-0322ca5dc10c@oss.qualcomm.com/
> 
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
> Changes in v7:
> - Move the "iommu-addresses" behaviour change ("reg" required, non-direct
>   mappings rejected) into its own patch before the iommu-ranges patch (Bryan)
> - Make OF_IOMMU depend on OF_ADDRESS and drop the #if guards (Rob)
> - Use resource_size_t for the size in vfio_find_dma() (Sashiko)
> - End the derived trailing reserved region at PHYS_ADDR_MAX - 1 to avoid
>   overflow (Sashiko)
> - Add a dma-iommu fix to protect the IOVA rbtree anchor on 32-bit with
>   64-bit dma_addr_t (Sashiko)
> - Use the "iommu/of:" prefix and fix the subject case
> - Link to v6: https://lore.kernel.org/r/20261103-add_iommu_ranges-v6-0-361f3921a133@oss.qualcomm.com
> 
> Changes in v6:
> - Addressed sashiko comments.
> - Addressed comment from Bryan.
> - Link to v5: https://lore.kernel.org/all/20260926-vpu_iommu_iova_handling-v5-4-0322ca5dc10c@oss.qualcomm.com/
> 
> ---
> Vikash Garodia (5):
>       iommu/dma: Keep reserved regions below the IOVA rbtree anchor
>       iommu: Use resource_size_t for reserved region length
>       iommu/of: Make OF_IOMMU depend on OF_ADDRESS
>       iommu/of: Require reg for iommu-addresses
>       iommu/of: Add support for "iommu-ranges" on a device node
> 
>  drivers/iommu/Kconfig           |   2 +-
>  drivers/iommu/amd/iommu.c       |   2 +-
>  drivers/iommu/dma-iommu.c       |  32 +++++----
>  drivers/iommu/intel/iommu.c     |   2 +-
>  drivers/iommu/iommu.c           |   2 +-
>  drivers/iommu/of_iommu.c        | 147 ++++++++++++++++++++++++++++++++++------
>  drivers/iommu/virtio-iommu.c    |   2 +-
>  drivers/of/address.c            |   2 +-
>  drivers/vfio/vfio_iommu_type1.c |   2 +-
>  include/linux/iommu.h           |   4 +-
>  include/linux/of_address.h      |   2 +-
>  11 files changed, 155 insertions(+), 44 deletions(-)
> ---
> base-commit: 2637bdec0535a2044cd830eba9a79363651d9043
> change-id: 20261103-add_iommu_ranges-549cf3fb0867
> 
> Best regards,
> -- 
> Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> 
FYI, we need this series too, for the extended mapping support [1] in
the fastrpc driver. I'll be posting a new version of that series soon.
[1] https://lore.kernel.org/all/20261007-extended-mapping-v2-0-5dca3aa2c2d3@oss.qualcomm.com/
