Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793739746;
	b=H3AGMF1iDztIBRaOWbDeCRIiCDa0DvqMXejD7rlnYlmJ6JcDiDQYuirzAyEEQbXlqIso
	 CJ1r5Eg+cMYHKzCtdN9RKfs0AOqc1wXHkwv9TF2ok0lsPYu6EG7tBRKNMt7C4R+vp6pDA
	 DddvHs0WJOainUJX/wUW5c/AOt9oSO8HqQMAcovNf7kMwmZH2eTKiBlxpYV+MdxVRAHbg
	 khJgvOIBXER9Qw/60SFp1yEsxXZGYNDIUiLu5NY5tH0vq9km3LoLlwHYC1YJNTD19k+k8
	 X+KVKYbuT5Ow84gLT37XXb9U53o/rMlKblw7xbfS8SfszSsv23oMhxU/97ln3evujDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793739746;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=7L/kjnfMz9A0ktTU8C0Qq6Ox8RbkPb5fZACdQWXlPe0=;
	b=u+5OvU7bC3dzMx+6C2LlWvElzknqVNve1juTsuw7uQ6DRfgYrZhVT7qNksap1eQq2Wbc
	 JrozWJkVjUIPAuobM0QOOoyidGr7ooYSiucVRZ6TijQ+RvixL3sDxmhBi7B1990LSonLK
	 0Qm7mauHyQHo3F6nDOXos6HlUAK603Sd1CGipAkkoXS1xFLUZztNUaJcxRjyz1OHgXCta
	 vRE0Y7MbRpui8dlui1Ny3JYznAW5z3vNy8lIX4rsEffZq7UYWuiyu4iwhVfGsulU1RA+W
	 3k7kBG8dsXwu1961z0QJda8wxzHHGN8CycS6w4vQgdBxHii28U8P+ZP4gbuUxAgUfcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JPiOdnnW;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RDS5Oljv;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC0A606A330
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 21:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AC0A606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JPiOdnnW;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RDS5Oljv
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3IZ1G2445336
	for <iommu@lists.linux.dev>; Tue, 3 Nov 2026 21:02:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7L/kjnfMz9A0ktTU8C0Qq6Ox8RbkPb5fZACdQWXlPe0=; b=JPiOdnnWfA+/xFyI
	p2nW9Dn4LDsEyt3BDwjrQ74Imw4QivpB7aKbeapzNwoDLT1rxw4hZSWvcpO4G/qF
	L7sHNxtHvRHpdjWixSxng+oz9IAB8A0nVsZo9Di62/gBEeuyBSsQHC2l3Kp/1qAy
	V7CmWUbAz4Z+7QL22LsTq5xQdlc7Bnmxujh9oGJJWlWc4pkhfddiJ1VoygyHNpuF
	E3GRBPcnnVY0z4E3889Mng3st8diHFzMIdGY156fyWcMZXT19U7pPWMiylP150p/
	lZ8IMzEXN7qujPBVHaZ8vHfqubNZC7GvahSpiXxoF1f32u1990e7pRm+6X6OL/yP
	miP+WA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqm2pgtn0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 03 Nov 2026 21:02:24 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-341eff9e381so9898494eec.1
        for <iommu@lists.linux.dev>; Tue, 03 Nov 2026 13:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793739744; x=1794344544; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7L/kjnfMz9A0ktTU8C0Qq6Ox8RbkPb5fZACdQWXlPe0=;
        b=RDS5OljvogzL2sAgzAACYuVackOqUuwqK/VIZgvDJTDGO2yVJ4pEoUCVU4BQ6fNJsX
         DbR7FrJUJki6YSWEW7bacTGu4n6ppLV5kIwl2rPvSvxEpmg50C6MHOE97wRg8EaC5+oh
         Zkj/D3H+SSHk7qaxwGywGkx5yq2fzOWVWQf6HgmLTQOTVtamhe5jqzAO68F+DO+vL2CL
         yjvhLkboHGw/ZNAwKYS6fNW6mriql7Z2aL4ZAdM34/N/MqOvmIM53Mq17533SCgRfhnV
         K+sRtU4hUcdVrpC7dYVVEOH1mfgy2L86K2dmwDhpYXyu2vNCeDZUp/OmRPCOf8ohk5/B
         9EMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793739744; x=1794344544;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7L/kjnfMz9A0ktTU8C0Qq6Ox8RbkPb5fZACdQWXlPe0=;
        b=hwDHFhalJFS+2E7+zATduVc+GXDICTDRAiFv3oBE5OMUbja2p6P7IeyiViwgo9L/0j
         cYnPeRwaQBFBRrQYEpMesYMeXcxFt+2ntSgCR4ZUmMtJUqs8xhbTHfBWj1RD+h//UOpg
         VeD7t9fXFyx9ldEO7yAqUlEc83a5FzqoVftnZghssYcuxWZJ6AMHOUV7hxTQ0jR2yUhC
         42Mkx6FltQo69GKMWfbG9Fn89smr+h9t0mOp0LOlzIh4tDO5PsMkj1KW+UVQQWBzM/1S
         ceuY5bgu0SVJ4C1whyqu5Bncoc0NjoI1A7+MlbGwmiqhxtPObhJyT2eBqhg7WYmMVJMf
         MYvw==
X-Forwarded-Encrypted: i=1; AKwUvBzoxzA7u4bg8pM4zOTYz6I7nxeQPVUpqllYAEOh3MXb+LGQm4gh0L7E2HPGJGhUmz1yhKZSSQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9PodAANof/hF6f6wq5oCTJswqk55Xz2xCV70yPpXqhBFxfltn1
	dDAkuJnqN/uTQ8z8xo0nsnnluG+QOg49WWr/uV9jMR68fdPmrgRMAaWumqbLHp1JFkup1cVZgHn
	9WG8/i4tY3GeTZKZirC2MOzNLOVziG/v+jebMQ6FVgJr2mpVsoBLeGeVX6w==
X-Gm-Gg: AYBFou2He7azIPA2s7X8d6skMhS6WYq+a4XmXp9OC8gkLJ9sURmj1bj15gMZSWr66L3
	oWST318AEl3ndYiNrJ3uDW2Jp0Hszap1co+ImNclDmMuUuCi9OInF3OMtpS9hOrFyUEDspEM1P8
	K9RBGVf/1hR4gneSTRXOVWcKAaB8MZAmZBYZM54hLxZQD21cgPq5BzryinMSg0GlALaJOxRlwHY
	Gi2ygGlNTM+eKBrV4Pu1FfwbtcCEjLcbpEIQ2PCUQ+SZVLRA+qdQK1JAY+F+fJfb7gFlLkTps8C
	xKm7bdqVT99UsGC9QUTkzF63DWHVo+logRCqcAb5T2lnNyaZc7108Tl9XYCeZKA5Rve+aU7u7qR
	MsChGaJ9YK1ClkerU4+kuJja/jjHm9+9m2YeyxYw6ZA7arCXQ4ITvUJVKfkzDUvRBTA2OC62m8A
	/7aCseakPvNLcFw0JFx05RySVixQ==
X-Received: by 2002:a05:701b:2094:20b0:187:efba:9ba2 with SMTP id a92af1059eb24-1ac5e8e1decmr22023741c88.44.1793739743651;
        Tue, 03 Nov 2026 13:02:23 -0800 (PST)
X-Received: by 2002:a05:701b:2094:20b0:187:efba:9ba2 with SMTP id a92af1059eb24-1ac5e8e1decmr22023667c88.44.1793739742820;
        Tue, 03 Nov 2026 13:02:22 -0800 (PST)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c2de58sm1260017c88.12.2026.11.03.13.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 13:02:22 -0800 (PST)
Date: Tue, 3 Nov 2026 13:02:14 -0800
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, <joro@8bytes.org>,
        Bjorn Helgaas
 <bhelgaas@google.com>, Will Deacon <will@kernel.org>,
        Robin Murphy
 <robin.murphy@arm.com>, <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Joerg Roedel <joerg.roedel@amd.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang
 <dave.jiang@intel.com>, Dan Williams <djbw@kernel.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v1 2/5] PCI/CXL: Probe the underlying bus reset in
 cxl_reset_bus_function()
Message-ID: <20261103130214.00000b82@oss.qualcomm.com>
In-Reply-To: <auorjXgbVPXZNHZL@nvidia.com>
References: <cover.1793729707.git.nicolinc@nvidia.com>
	<6c09d2f78d4bb9db7f49fa14a6550f5176721121.1793729707.git.nicolinc@nvidia.com>
	<auorjXgbVPXZNHZL@nvidia.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA4MyBTYWx0ZWRfX1UDLl4s4B2aQ
 /YJ6waT0t6ivsaIKZ8fVUg7NfmR5AKpNgX4JReNltPq59IQzW2ux8NfL1KuwRJJr/5gHbkIuYBl
 rbDOmTjE5GHNLhYSkwYC8B/SX/IBPK1lc3nFqR3gKloZnvjhfN5kLipoyAiRIy4xakyIDjRLvnr
 oldhDdYHTum+pDyVVYx/aPrJaJPVuCE7IBJPArcjkEmjcxB3DtN8iR6Y4yJmcYS4Y/RfG4ho1Jo
 RYiqgYol87pj4RfLFsPaPEr1vShJlXN6eoCtwqrKxZseTUCy8lw0/tlL125IAojQUknC8n+hR5C
 u6S2jJIRD+TKBalb6Qr8Fm+drdTanxxeUfos51fy6avJy938MRvTNgiNwWLw1P3k5OtiR1QTMhJ
 LlmFfHM9w5Hzdr1A9dPBx1RVO3bKT8HJBeLI9mqfWJy1KsFNxa4ZAx6proaTEtkukp4B6bYs/Xp
 0FpHvb9nw2KzMqIXJaw==
X-Proofpoint-GUID: UzyLqw0rlyUTd9EkTV7c-kGHVKhdh9FN
X-Proofpoint-ORIG-GUID: UzyLqw0rlyUTd9EkTV7c-kGHVKhdh9FN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA4MyBTYWx0ZWRfX03HutZmv3G65
 PjOd3tHkXIjQdHrEKc3EYLf034bZz2FBARQL+cNvgx80XRBQcm8cMPAn4lwVd4cJKW93exHMU5A
 HVHxLmqejlgSGnrv2hLZSm3UuFqLDXs=
X-Authority-Analysis: v=2.4 cv=c64+0h9l c=1 sm=1 tr=0 ts=6aea4be0 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=EUspDBNiAAAA:8 a=Zdewuh5ThNVhPH2xqRoA:9
 a=CjuIK1q_8ugA:10 a=O8hF6Hzn-FEA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030083

On Tue, 3 Nov 2026 10:44:29 -0800
Nicolin Chen <nicolinc@nvidia.com> wrote:

> On Tue, Nov 03, 2026 at 10:33:43AM -0800, Nicolin Chen wrote:
> > cxl_reset_bus_function() reports "supported" to a probe after checking only
> > that the upstream bridge carries a CXL port DVSEC. The underlying bus reset
> > can still be unavailable, e.g. on a bus shared with other devices, so both
> > the reset_methods[] array and the reset_method sysfs node end up listing a
> > "cxl_bus" that is guaranteed to fail with -ENOTTY when it is attempted.
> > 
> > Probe the underlying pci_dev_reset_slot_function() and then, if it is not
> > applicable, pci_parent_bus_reset(). These are the same two checks that the
> > actual reset runs, so a shared-bus CXL device no longer advertises a method
> > that can never succeed.
> > 
> > Probing via pci_reset_bus_function() would not work: its cxl_sbr_masked()
> > check rejects every CXL port with a masked SBR, while the do-reset path in
> > this function unmasks the SBR before resetting. Such a port would wrongly
> > probe as unsupported.
> > 
> > Move the port control register read above the probe branch as well, so that
> > probe runs the same checks. That read asserts no reset, and a failure means
> > the device cannot be reset this way, which is a probe-time answer.
> > 
> > Also pass an explicit PCI_RESET_DO_RESET at the do-reset call site, since
> > probe is always false at that point.
> > 
> > Fixes: 53c49b6e6dd2e ("PCI/CXL: Add 'cxl_bus' reset method for devices below CXL Ports")
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>  
> 
> Ah, I missed Jonathan's review tag during the split:
> https://lore.kernel.org/linux-iommu/20260926001311.7c4be583@jic23-hlaptop/
> 
> Jonathan, would you mind giving another review tag here? It's the
> exact same patch that you reviewed. Sorry for the inconvenience.
> 
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> Nicolin

