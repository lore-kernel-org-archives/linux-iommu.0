Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F19E4ADD92
	for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 18:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789151172; cv=none; b=e0d6um760QGyN1r0uNTvhbp5tOuE8LN7bT7qAcgDLb7fJvGv/2p8KmVRsS3jLomQ/FBb4+VrBVdFaTsZG0KWt31SlpWGND9jlJqh23Ng0hMNHchEG2UxnNhhyqH6D5A3Drza32hNif2Q6rWtd/lKW6jAzTuRc64TDY8l+QOcElo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789151172; c=relaxed/simple;
	bh=CkOP2YwaxjG0b5Gs4zSDT/f6WxnNkC7kiB3FD0vefeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+VAIktK7G07DXlGIh3wClZRIsyrw+4E8QB8stuKR13rVvh0B4N68QPCphCjM71xaxIDE2XEuQ3rotTB4YQJYi/cfwQAjs6RtOBw/mt7IvkROyuvz3aBd5RBQuDMvIQzoIuZL5Z/49FfBZbJN0/THQmAuZ7dT9upUUvF+LwDQOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S6iRa0f/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VrgMaFUj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S6iRa0f/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VrgMaFUj"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BHWeDv488241
	for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 18:26:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=I2VP66MJnRkDMYUgYGBaZzpl
	QPMX6KJi2mSu6YYl52g=; b=S6iRa0f/eOeRpK4TSer2p1jlzG4oKEUPSsdSRohM
	u16+w6WgSxLHg6yHYQgpKQZ46M6wO8+N7TRqSf7VU+v6fw9ihrL8oxa7lkFqytdE
	NcqONgZPT4DSoBo3jM9CcZ95qPPaPix592m9ZKFfgujPYht+VXIk9/AwFiiSrR2B
	J1tr6o1brmEjA/ynHBv5vYR7FxscNkuA9PUfPAfRs4f1QsqS0vtbG7A9W+mFMIac
	0Y3nKzBWheaT6q7exogm/UrGAwwX8RNyuiLXViucbsGYivAqC31UlQN8ZFuILglr
	x3Vj1ZhE3hqlLceTel4S59WAQYuoI5bIhov3/kEncesvFA==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmm1e8sn4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 18:26:05 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4b26d8d2498so1538965b6e.2
        for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 11:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789151165; x=1789755965; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I2VP66MJnRkDMYUgYGBaZzplQPMX6KJi2mSu6YYl52g=;
        b=VrgMaFUj1xq2/DQQJtXVVsnVw/zcY99UDD0PjPZ9Y0rwvbYKfZeOwwYdwmQfCW7CAc
         hnDDQeT2yDsBCgZwqjWZ09byB+qp08prGe0fT/EM00lhqRtQKvLElcDz53P06HFln5Fg
         5v1Kb4C9kH+g4Xzw4n+XHxdE9+ZJG/1RMzXQjNt95WLILPYV/8rsaqCvXtHp0eoSntYe
         9lCDWozEvtJXTsfHaByLSfdTWgXvLVEKAghtOvus7CLUdJtQB51Xotvn2WiiLjjlZ50s
         VnJ0IDUwITvrn8IueJqRs4vUECMI/iJRZ3YNKMLVX7/k2kuIjY6PMuX+M4BIUUhL4lvC
         ucgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789151165; x=1789755965;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I2VP66MJnRkDMYUgYGBaZzplQPMX6KJi2mSu6YYl52g=;
        b=DquyK/+P2y0kLndDGrndaUV6H1+N8Cfr+Sb3/ke5IZshvquYaFS8FuceVhR44YEtSJ
         WZvViIrQIU0eSTeRCmLmg3yuMora2cdn/EsZmgsPGAJyAm8ppgLKN5bzME1nXVbLyYsB
         rREQG1MUaopVTa3WJlH8rFBBQwdSbx4aTD9rM7UWw0FQTGmC1SN8ChmiNYpVLXbrohDs
         7Oc31tkqn/b7CA4u/qRUlSXsOh15BJFGiHl+pXrJLd/GdA9E6rc7eeetqLjX9R8kASNC
         BEjY9XZ8YAzDdP1jgDvYSHHSfv847ZAGUKHwHvn2DpGPWkOqNkG2yoUT2G+u29UD/xv6
         S0QQ==
X-Forwarded-Encrypted: i=1; AKwUvByZAORo0uLJ17g6O1W0gsBXQoOav6QFFyg0SCrwcj46LSVrAPZUoSaRtGCtDJVFup/RCCpqPw==@lists.linux.dev
X-Gm-Message-State: AFuF++n/l3qJnztGbo2loOI729J+7aSapfRKxWB3vDKTcr0n58LT4wl0
	dyzBsOgutR8hC3utT4dujDNTpLfMC/zhSr8ufgEaGBWFOpxS4t/iiy/jTxgRiyS54EnRldKseZU
	GFp1QtvxFKxtBCJleBpqoM9ieBwVfU9CBX48tFYyFsqV/UjWjfh8+oR12JA==
X-Gm-Gg: AYBFou0uUbY3fvI/OraStXp4gZIUYyNtnbiZX3RpbYA6OX3QbTHCIIBYoWnL4m0w6Je
	t3qNlLvV0BafjL+HuezaOM3n048mgCRUJCN40ImG8dXsIiAw3P0TcMN1AxlQcNpi3TN53HhSBVk
	3Aor2rtyWfJ4Ea49V4F9tLsiGgCCPVdDYUIjc/7Af1rA4TSyydVraDDetVYVOSc0NgetZdQReTb
	i4r1+crkhL0GAEMTRqX30mGLjniPYjDrJpK1o6+tXfNrfN1OkL+sf4u4xW4rKnx7BsPYoGIHPMo
	bNRreVq2Gc+SA5R3KN5mM7WXA1GL58xmfP1KaztymLtsW0t3LIYKHcKWLPeeCAID+//c3En4avB
	TSHbE76Jghixg8XTsbPISQU6e1rkbCtsA8hV3uZwKnNNDXOm+Vg==
X-Received: by 2002:a05:6808:c2d3:b0:4b9:e5fa:8903 with SMTP id 5614622812f47-4c31b4c8dc4mr3978461b6e.22.1789151165103;
        Fri, 11 Sep 2026 11:26:05 -0700 (PDT)
X-Received: by 2002:a05:6808:c2d3:b0:4b9:e5fa:8903 with SMTP id 5614622812f47-4c31b4c8dc4mr3978426b6e.22.1789151164663;
        Fri, 11 Sep 2026 11:26:04 -0700 (PDT)
Received: from hu-ashoraj-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4c3327e9300sm2849879b6e.18.2026.09.11.11.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 11:26:03 -0700 (PDT)
Date: Fri, 11 Sep 2026 11:26:00 -0700
From: Ashok Raj <ashok.raj@oss.qualcomm.com>
To: Rik van Riel <riel@surriel.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev,
        liam@infradead.org, maple-tree@lists.infradead.org, linux-mm@kvack.org,
        jgg@ziepe.ca, kyle@mcmartin.ca
Subject: Re: [PATCH v5 0/3] iommu/iova: convert from rbtree to maple tree
Message-ID: <aqRHuO1rzkaIL0WP@hu-ashoraj-lv.qualcomm.com>
References: <20260818152505.1057922-1-riel@surriel.com>
 <aqQ2E68lmU3Fbjsk@hu-ashoraj-lv.qualcomm.com>
 <d2f5889660e97f03fae2cd43ae32d8bf8edf3446.camel@surriel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d2f5889660e97f03fae2cd43ae32d8bf8edf3446.camel@surriel.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDI1OCBTYWx0ZWRfXzW3zk/m+tSKK
 5h9zWn66n7Juk4oKRFMq+dsK3aXa+ETZVYetgwJ9LvY+O97XvJar1ByGlicSKhCwOpHIdXZEKd4
 +pcCp+BthPq2MKAZQcNPT3oozkMR7b9qXDANHdGogNVqdD/oUGn4yjb9dYNteVNgSjYCsCLuJNJ
 2M2j8D0NfQyRUJPrugYUgS43XDjf416j6Oc3eJovEZZV8xRCQ++BTIh/GxpPlZHrS9Q29ZKGiyl
 7dsmk4tclf3GZRCNtEit/wvebNy5EA2zpmcJwVpiu4LqezCqVr/nXQJQwJbbyQQRbx6nzWNYZYz
 xND61sM6R+xe4tvSnFmFFyaFCeZ7r7qwOVzEcRPts8J+lmWzP1GcpB40bidryyMZAtIfgf/PtJj
 s+LXIRUOuNUogVfpSMp73YGSw5dpqa8hr9t4SCH7BGZZ8ravms3Ot5bJmj8/MOGB/R+KNW1zekh
 1glrkVfuV+aI6dtMzVQ==
X-Proofpoint-ORIG-GUID: sJ-B6EGKzM6cBAZ2gpwwwiMG8ApNVEby
X-Proofpoint-GUID: sJ-B6EGKzM6cBAZ2gpwwwiMG8ApNVEby
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDI1OCBTYWx0ZWRfX3UidDTc7DQc4
 JLLGc7hdak2+th3uzKVe2lXz6LFZ5Vjf9JxgNHzdAB0jCtImEObk/iVctet9ZLjHh8gAUUd7c0m
 chh3r6ywvLomKZfWhEIYbXtMBS7uDWY=
X-Authority-Analysis: v=2.4 cv=LrwHWXdc c=1 sm=1 tr=0 ts=6aa447bd cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=eqVH15oDgQDJub46UIAA:9 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_06,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609110258

On Fri, Sep 11, 2026 at 01:27:29PM -0400, Rik van Riel wrote:
> On Fri, 2026-09-11 at 10:10 -0700, Ashok Raj wrote:
> > On Tue, Aug 18, 2026 at 11:25:00AM -0400, Rik van Riel wrote:
> > > Occasionally production workloads at Meta run into the linear
> > > search in
> > > alloc_iova() in ways that cause real issues. For example, when
> > > enough
> > > CPUs at a time fall into the linear search trap, systems have been
> > > known
> > > to get stuck for so long that it causes soft lockups.
> > > 
> > 
> > Something odd, except your cover letter rest of the patches are
> > missing
> > v5 prefix in your patch? 
> 
> Ugh, indeed.
> 
> The content of the patches matches what I wanted
> to send, though.
> 
> Do you want an identical v6-marked series, or
> should I wait for feedback on the code?

naa, just wanted to tell you since it happed the last one too. 

Unless you hear from others and you want to roll in new changes, this
can stay. 

> 
> kind regards,
> 
> Rik
> -- 
> All Rights Reversed.

-- 
/ashok.raj
ashok.raj@oss.qualcomm.com
Qualcomm Inc
