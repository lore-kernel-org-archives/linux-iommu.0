Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285C439282C
	for <iommu@lists.linux.dev>; Wed,  9 Sep 2026 17:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788976707; cv=none; b=e976bY6qNBUR73BCQnRyaBxXO4jO863zCUghGkYtzd9uyZvE6xmNATidnR4p93qm+w/6YIsIJwxkvHGAGpjDatWU+NL1c2JJL6LRnf0eCnBc1TBCdJc2yfbDnsWhxCqmtDzxLNz2YXI/RY60dy2d9rmLHqUScGCJ3anM/Cxl7Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788976707; c=relaxed/simple;
	bh=Fe6nVRkXFn8YOQFqrHXehrUUPgaHC++2tndyandA/E4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E9coW++OmKlQwm687xvvuEHhb8MUtUuwlPqW6aUvC09vnRRPaubpV/S6BAd45mZvAp3qaTmj/TWfLhnq8X84S9MuEZeN/SiMZssz1kA940Y8KdsA9nn2Aa7n7EvB+/ViBbi+KtxD/nDiIYDKIkuhMAp3yfuyGxG6Sj/YbqK/3Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gJqS/YCD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h6bX+XFV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gJqS/YCD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h6bX+XFV"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689H86Z31938184
	for <iommu@lists.linux.dev>; Wed, 9 Sep 2026 17:58:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A3G5n1JEubzvFQoHqpYm6GVn4ifURnR0UinvnQLMEbo=; b=gJqS/YCDncjuUTiC
	uQBCyhOKBKswcxjl6dcirxA+/EYMfhJpbDaYZ8t2Qb+j0kIcGJr94D02bT4oTxRc
	ucBScFxNoUMrzNYGQH5TbZKwBs/LPzgm96WWjRzoQwP/V70T865RcJ9k0NV4QCIY
	M9CnABckcXx56rPcHxSN2osYwc5n+PQQEaKdLiMBnMXKcuEaiHatLfnuUMhedEPV
	kshbzVTQnObDG7B5K8+vJifmzUyRTlsLIFDYN9QgqPsTR9Nr/Ak7UpfP0tk5dou9
	qFsGCtsbH9p6K0eymdvsAX/1hKw9oxHwvpMjKZ8UWwJaedIjvMbEQGRynfcKIC2t
	nBknwg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk559t747-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 09 Sep 2026 17:58:24 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2db0a41434bso111605005ad.0
        for <iommu@lists.linux.dev>; Wed, 09 Sep 2026 10:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788976704; x=1789581504; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=A3G5n1JEubzvFQoHqpYm6GVn4ifURnR0UinvnQLMEbo=;
        b=h6bX+XFVDP4mGOE7FOIoJC26g5HFMGFdfqZOkaHLGTAgyuYQo1d6bey+bpv39qwd9j
         MXRKY942Rf4sJ4221gUExQYXaLMiGGSAErYsDqosoNHXPuVOisULuyggtAH3BMqakBKs
         6wyu6W0TJM3ZV7lKZuFtZryDo/TPFc6F5+w2m8ym7IvFZtWda+1wWolCD6GSCrP1/fv1
         p0BGqNpHPt5Sewa72lxvMp/NMQrmJHVB346Rsw1mo4slfWFThIqKFs9yNUa6J5GBXzrb
         Z68k+0NS9DmmnQZy92DHFWC0wzJa9o7dKJiqK03rn0SCCqyjro1MvXDF6mDj20s/eAon
         mJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788976704; x=1789581504;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A3G5n1JEubzvFQoHqpYm6GVn4ifURnR0UinvnQLMEbo=;
        b=sBe7Vuewti3xIdXjfwoAK2ENejNv9vCIimV5MXK+xK4Np9HTENUDfRjvLFu3LtHafj
         z1WZL1vJEYIX1UDaDcCq+76zqAmYoz40XdLIIqY/w93M/2rRzpEq21Ym/yikGbmskJbL
         QKu8536VClHcdCo3qoWYe1CnyW62jb2aglYFC9A0zytxdX5+yLtvL8Fzr8lVFsKpvKHN
         nqXtYt42gJYMtC7BTH9YPdMHxKI1v70sM75/bzmJaH3eWPBBKKuxN6Vtc5HaA1FgCafl
         4iR4S8p/iVBArSDv3tAVKU+WpX63/02ugH++gdRiTBokmShvxrutE9NBM7x15136lLt3
         HyoA==
X-Forwarded-Encrypted: i=1; AKwUvBx0Nw1dIbuGAUrK53MCdgKIV046HsVXNegkxPipI7mmUzmba3RJ50T6fBdNiBywsLN7vdDO/w==@lists.linux.dev
X-Gm-Message-State: AFuF++loLXmS38k5toQDYKmNsSmCf5X7aHV4kdt/1mC7ArcAimpODjNB
	ZDt3iosBAnyUIXtZLhG0wN7motZ+zWHCrhjAVz3LKgpPUJ74pAo15z0HLqo4zrya9TK3QAxEPW+
	L0yIB05ikdn+xjMIlq5R88Bs/GoNj4JRRlj/5rS//IWvbSkyPwCREoKPkvw==
X-Gm-Gg: AYBFou2JBbShTQ2qaglzTuZ+NKI1dux3uo0Dek1BsBv5HvJP25EFK7qSUi0rbxYbRtK
	IBKF+pI97PFNYKYj5CDIawvlcNueKaJBAhgmFnOg/prQilWE4KdUK2KIXYElyMWXyrVpWCM7EtN
	bH8kGDACIcsDORNHGH7DNIEHl9eShaDM0Geuv+3iReKGCqj/YXeTc6ti/wC+B9AS8kT4GcgYHwq
	bdWMrVnemeAaNOOpan6nDCo6ipo5FZ6Kpw0SyASAMuzmwn7STSPYYJGDXNx6QzBhZxnFZJqyt+6
	29HqxczZdGMqv93P5WuAxkvM7qJ3mvI9oeHO1HkIpv6FLmHUVhJSobB4YNv73fjnq/qKhERpnRR
	CatMJC6z/drFvaW3K797j6GDSc+U=
X-Received: by 2002:a17:90b:4d86:b0:38e:6aa7:68ad with SMTP id 98e67ed59e1d1-39d70980956mr2813337a91.5.1788976703363;
        Wed, 09 Sep 2026 10:58:23 -0700 (PDT)
X-Received: by 2002:a17:90b:4d86:b0:38e:6aa7:68ad with SMTP id 98e67ed59e1d1-39d70980956mr2813204a91.5.1788976702119;
        Wed, 09 Sep 2026 10:58:22 -0700 (PDT)
Received: from localhost ([50.35.44.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432435ec2bsm40569970c88.3.2026.09.09.10.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 10:58:20 -0700 (PDT)
Date: Wed, 9 Sep 2026 10:58:16 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
        <joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
        <kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
        <baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <skaestle@nvidia.com>,
        <mmarrid@nvidia.com>, <skolothumtho@nvidia.com>, <bbiber@nvidia.com>,
        <harsha.v@oss.qualcomm.com>
Subject: Re: [PATCH v3 07/13] iommu/arm-smmu-v3: Disable the queue IRQs
 before disabling the SMMU
Message-ID: <20260909105816.00002e4d@oss.qualcomm.com>
In-Reply-To: <apuLhri9BpqncLRT@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
	<a6fba7f7a01f5955dfb44d34adc6262c8534e829.1788222486.git.nicolinc@nvidia.com>
	<178846311318.1308030.6301643510859406126.b4-review@b4>
	<apuLhri9BpqncLRT@nvidia.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KP1qylFo c=1 sm=1 tr=0 ts=6aa19e40 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=aNnz9XPx1a4JIXSYt2cE/A==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=Ikd4Dj_1AAAA:8 a=YF44DY9b4ahQXEfF3N0A:9 a=CjuIK1q_8ugA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: UDL0S8gzaE70toAHDNEAMwywqKcfeRJp
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDIwMCBTYWx0ZWRfX5O0iKmT0N+Q0
 2twnNJOqDtJhyXQ4ReGkKh57yo9JLHwy1KqmWRs5G2rXAuwTCIvkFyLvMOaexFQ9r+Ovvbrq8ol
 QdfJap+zwNcG2+Eb4eSfHNsViQ4dSLY=
X-Proofpoint-GUID: UDL0S8gzaE70toAHDNEAMwywqKcfeRJp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDIwMCBTYWx0ZWRfXz104sIv+1s3T
 BwIdRrXGfP+7d0BqoPuDuBSEqBbwxM58Ltf5cOo2MHXOjA0GcoLoY/9TLSX9eqNtOEydFbKWSog
 7zUjefLf0CxNyNRxliGKIdBWs3O+mpSlheXZ3MtvLQ4ZSDheCM39NIEzcXzMZEMyHijMi6i3dSW
 9Q9IARgyHK1gOP/qfpl0AjVhTp8v73YP+rKSaLF74e6kzsaMLkoSFBVUKpuAJ/Kfr9pollsnu3m
 4KHdfuqv2fmQQCGBlvLdnVZEQdnzqD8c1OD0PyMjD64cxrZaX0gWdRGw6TzVY2RhaOEZjDgpDOx
 SybVcR92b32YyMwKuw57cajglezyQzJnk6qwo0XTypWsZRvYz1vb10P39NRfU1lntPMriyU0ctx
 8EqBkCxxobwRamKt6EKcA3GINVYBxnBroyil+ezWGKarsGeYv0dX1BxeDE33qWNQ6/vcfceM0UG
 bfjHMdvfLtYaq8hELQQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090200

On Fri, 4 Sep 2026 20:24:54 -0700
Nicolin Chen <nicolinc@nvidia.com> wrote:

> On Thu, Sep 03, 2026 at 12:18:33PM -0700, Jonathan Cameron wrote:
> > > The EVTQ, PRIQ and combined IRQ handlers are threaded and issue commands of
> > > their own, e.g. a CMDQ_OP_PRI_RESP for a page request. Disabling the SMMU
> > > while one is in flight hands that command to a queue consuming nothing, so
> > > its poll waits out a full timeout.
> > > 
> > > Two paths disable the SMMU while those IRQs are still requested: a failing
> > > arm_smmu_device_reset() returns to a probe that disables the device itself,
> > > and arm_smmu_disable_action() covers an unbind or any later probe failure.
> > > Both can run after arm_smmu_setup_irqs() requested the IRQs.
> > > 
> > > Disable those IRQs first in both paths, so that no handler is left running
> > > once the SMMU goes down.  
> > 
> > Why this soluton rather than a flag to stop them queuing new work + a
> > synchronize_irq() to deal with threads in flight.
> > 
> > irq disables always worry me a little as they tend to be patching over
> > something nastier.  I think this works though so I'm not going to
> > strongly object.  
> 
> Well, I don't see a reason to add extra flags: each irq here only
> has one single source, so disable_irq() is fundamentally similar
> to a flag + synchronize_irq(), but also masks the irq line, which
> makes sense in the probe-revert and shutdown paths. Above all, it
> is cleaner.
> 
> If there is a solid reason for not using disable_irq() here, I'd
> not mind changing that though.

It is probably just my mental model that disable_irq() is normally
papering over devices that can't behave well and stop sending irqs
at the source end.  The main difference is whether there is any
potential of the unhandled irq logic kicking in.  I kind of dislike
relying on exactly how that works under the hood (needs a lot of
irqs to trigger) for any path that we expect to actually hit.

Anyhow, I don't feel that strongly about this one.

Jonathan


> 
> Thanks
> Nicolin

