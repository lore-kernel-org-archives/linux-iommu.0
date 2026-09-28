Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DFE49AA38
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 10:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790590986; cv=none; b=iYKmj7SllZWhlxZRFQXHXs5Qlx8DONHumH1GngYjncUflDKGAiaeXM7meqZSSm6KUowBZ83nTFjyfMiHdag/oB77YJzcmS9X46BW3fqNRq+HXdVeheKkF+my4bdHcPsHPIIRN/j+P9kj/pwuBRMmbwvEmExGePhW4tOjPyYiRgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790590986; c=relaxed/simple;
	bh=ECXWsUnejBZXO7MJL+LoyKce69tcLd0fIXkvPlMdWmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6ZIhUoCXLJM8+NoK02nEqvGjvCgSNs9VNjg33ExBCH9/SsJW8A/RCGVsJ+j670fX2tT2hCjObdnYliAXnY8LL0JUiTSk0ZNXFtvirdiKt8HH3/DtQLMmxZ3oUSQEeltfSqC2FI3p52z8eL6kaclsQPSrlXXKk3nFBZ3HKTKZx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VWga3LQm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Tf1KWSwg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VWga3LQm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Tf1KWSwg"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68S9M7WU1195690
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 10:23:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3QURnDCY7An5xGLNpCoc6F3i
	MxAhLlXcypiYPCF7hak=; b=VWga3LQmgyLSQieWMTHkkLx0g8x+kECFnzZbPOUB
	jwYRaR0R1GM+0CgFC+Zp0gExgtdnO8KMV3ynBV6jviGUnAjpOKM+OyPLjy/UmwZk
	AtaJXp6Wl16jG5lVYa1jrkUfOT1ZXg0/ip87IFTKGpWYtzGLRJbgLSPskUofMd0W
	9VL1uECnsJOd/bX7xS2fkODhKPMAqEp1L/MxQWwxJilsT3h9HgF7YLp8lTM93m7W
	k3sQ4nNsuYHtomz9wMxNMLvRdjXBaup1t0v6RgeJ0fNPfDCyRSGi9S7rmv+7Ykvi
	Q68iwvFNyll+JnO4r9mODYPx2ZhzXxgMA59dK7uSDEQ3xQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyj2s133r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 10:23:04 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-934956beec8so624045185a.0
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 03:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790590983; x=1791195783; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3QURnDCY7An5xGLNpCoc6F3iMxAhLlXcypiYPCF7hak=;
        b=Tf1KWSwgdRD+8S/d3RL47x95MUgsfnV1Y1OsFc7DAUNvISCiCACcRs8f1kCgLHKxY+
         qgOi/Hq9pkgHsEZdmHhOPOHb3rVwSCjVAJ0myQNk08TZNe5b/QzOsZQLyXNalLRTeGqg
         ig6l6JidPqmNHhGHwFXM7T6muyXBXQa2xh5k+AZkgl2QgtmxdGjTao5BZzPCGF/4KXOO
         xUC96SKmy3AzOPVsYyqGS/Qcad86taekNAFhpElL+ybiZZcwW1oaETY1oOBhTJ6o2hXL
         qVaNhKF/DWgZVhVzbMf2pVLuV8N6Pijbg/o2DcrKSn8ECvttib+AOQ+PQLhDvXx2rD9q
         itCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790590983; x=1791195783;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3QURnDCY7An5xGLNpCoc6F3iMxAhLlXcypiYPCF7hak=;
        b=mSdygAsFkmNninxiV1XExYzu+5A5ZUhpr7dD3MJAeXf1jYcJOYm0Wy3BVHYu7L4243
         7co4eFEPN6T76sTfoXg9HBE7sJDEnLIXIHNh6CT3d1HsmNldsQHPm9KYYSL3HlM5bQl7
         TB9AW6VxZ3CG1gI6fmOvE2vSBs+yppvpT1LXO9KAtPqb7B6yhgKrqBt35teM3lM0wiXl
         a5iVyMJsJS+hoWQ3ujKcR1OI5PqdHZO55OGQ8jX0ojF9shEYpagyHDQrU6wiTul5pp+f
         wvWmxJ1cW2NgZCkEIrHG6400YtoTbbuJpmCCGJ/3nlguuEOVgOfiN9//RpGnfzsnurTz
         7AhQ==
X-Forwarded-Encrypted: i=1; AKwUvBznRbRLxB7yooVy0VjvwZmyeSwrFYjHnsVLMAD0HSQ/60J8DxzfGwvGrUkhDjHIJZevP0syJA==@lists.linux.dev
X-Gm-Message-State: AFuF++ni+iJv7pj0KPqOcdt0sfFaJkGj7x6cmVgB+HxXo0mEo0AAMDFy
	SG9YAdVp4BvanB4SMpp+c4DEOVCL6ziQMyXy31Wp+RROvSXaNlycZWKz3EpToo0PfBQFSjY2TGU
	fLaHpnBvD+eMzAtWjEENUYeBiQG2Oz7bJHCBtEDV9ClH7dlsodv+/Xr2xwgkeA/Nnpg==
X-Gm-Gg: AYBFou3/JQeY1z/BUxICe6gDZCtogcRyyJ6pdytI0JoNvSGpI4A21o37v2v9mBPvYEd
	d1AX1QLs62BjBQPpDI3qzC7mdtZsLlnvZk5V0w3YpzCoUGwr420h95O8EAQuVlotCEsv6fQkUOb
	MHOM1K9guE8kN6pMG9sQRDZmnCbmzmaTJ53L1VzwO/x+DCc1IQB3AUWtdS2y0+HrG0JCTMqeHGW
	4KFWTAKcMV4152Sp1ZjbycsB6VlFT+UUr2+Byi4HIHJkwA6fb7lWjLwSExiA2eu2CyLS3LT4nR5
	a8pcWOjVcyosM30oHNGerF42suqRSsa+F4nZzbS5fAST490m0Bs5MMTJDWdi7nst5noGM4zdBtn
	wojxFA+liNmiWFoTi0ytr3pLvLnW8zs6oEP63FQ==
X-Received: by 2002:a05:620a:1a08:b0:93c:6383:48fe with SMTP id af79cd13be357-93c63834d3bmr1077854185a.65.1790590983027;
        Mon, 28 Sep 2026 03:23:03 -0700 (PDT)
X-Received: by 2002:a05:620a:1a08:b0:93c:6383:48fe with SMTP id af79cd13be357-93c63834d3bmr1077849885a.65.1790590982538;
        Mon, 28 Sep 2026 03:23:02 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a007fd1847sm45517565e9.1.2026.09.28.03.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 03:23:01 -0700 (PDT)
Date: Mon, 28 Sep 2026 12:23:00 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v6 07/16] iommufd: Prepare software MSI installation for
 address lists
Message-ID: <jiouhcgwcqyp2l3uwvy2cswgelwezs4bmnk3zgsvkbs6kb2tjp@x2xr4ulqlp7g>
References: <20260925151659.419512-1-andrew.jones@oss.qualcomm.com>
 <20260925151659.419512-8-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925151659.419512-8-andrew.jones@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0MSBTYWx0ZWRfX15XzFim05fys
 2t8S/niRlJCrBd0Uvje0YP8VW55oAxgGdWSks9kIJql/uMqqWtKROYVXGP0c1yCEWNJIHE0F/09
 phC/rzb3JEECE5AGlAtMYRLsVHOTk2Tc2bVsQVd+BqwF5uuZbraB6v/++l7ITldZKEhFkVQWD2W
 49JiFv3TV2/LuzDHQ3PT1n/aa1zblFBxkYFw5JkUb2HARyVoj3TKhmJwqjZIqwoCSsxsSMrWleZ
 Q4wttErpniP2z77feWP4i8XuEuGioZtXgt1WcPo2HOxvTF13tQNYiTdGdP3z5YYKcURyiUUp+XY
 9k6MAB++rPN7jktm8cOVl7V5iQVbuTVVDiwSi7WJ4RivVkVGIaCVMDNfoB2jfqisOU65O1ELrMy
 RKD53mlliiQnmgXcEIV9sQB8HPm76hmcJelJ1D6u0FLp3W6e4jOw6sMxYj1Mdw4AoS9M1pIQZO2
 TdpTRTka/EF+alazoLw==
X-Proofpoint-ORIG-GUID: lZp5s0jGXSCv_hfbGTLfSHCQU6HdNlSl
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0MSBTYWx0ZWRfX0E69FyNWE1kY
 qH0q1wtDHZQgYRKqN4W9mL+2UwGfBJ65/ZeHV8mnomnLvrVqSz6kKiLPsvmLpprFBD21vT2iZUj
 yuO+W4ka848emlKzgHqS+M46nopCHWs=
X-Proofpoint-GUID: lZp5s0jGXSCv_hfbGTLfSHCQU6HdNlSl
X-Authority-Analysis: v=2.4 cv=TptzFzXh c=1 sm=1 tr=0 ts=6aba4008 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=SRrdq9N9AAAA:8 a=j5oeER8E0eYNLuWwjgYA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280041

On Fri, Sep 25, 2026 at 05:16:50PM +0200, Andrew Jones wrote:
> Teach the software MSI path to install every mapping in an address list
> before publishing newly allocated maps. Mark the complete list as
> required by the group and roll back mappings installed by a failed
> operation.
> 
> Keep iommufd_sw_msi() as a one-address wrapper so existing callers
> retain their current behavior.
> 
> Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> ---
>  drivers/iommu/iommufd/driver.c | 101 +++++++++++++++++++++++----------
>  1 file changed, 72 insertions(+), 29 deletions(-)
>

Regarding the Sashiko finding for this patch. It's complaining about the
mixing of goto and cleanup helpers in the same function. However, there
is already precedent for that type of mixing in iommufd, so I'm inclined
to leave it unless somebody other than Sashiko shouts.

Thanks,
drew
