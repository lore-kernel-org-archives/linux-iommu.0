Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A239547ECDE
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 21:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789420258; cv=none; b=A19t1hqNr1PabDoLf0Sp9rlUHyzF3vmaL0eSKTc9sELEGqhqNLmZLJTF1Sw85J/K5Wnj3uwxbURcZGnALJh1LoN7A5wNriJtRPNpGwfjUkdUyTgVp08GIB6Xh30uJr/Q3ogYKkJSg5cIvaUSvAoS2BA0GWr315ugB5qnWrcx4mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789420258; c=relaxed/simple;
	bh=Wq4dzX7G0MYHQpVoOYjnieG6feoqecTnIZTO7wV2B34=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GMQQv2V8a2GDAEFp2wqu46+CracLuc0mMSHAzNfYPcmU4R8aAYv4AFVrgm9BTpwn9jToZDygOhj9c78kV2fhBhuj2zd2AEX7ou5ms4dRCm9AZW4p3JjkVVuyevhuL99Ct60D3O6O0jJUUaNGgDlmuht1G/YvkHAlTljhg/Td3NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jp5eldK1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LElZwKX0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jp5eldK1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LElZwKX0"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68EJYc5u262569
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 21:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p6Z+iVYBfNSCWeowkj5JZHLt7Ogk7p4zAvjEwB8LuWA=; b=Jp5eldK1rwlCLxUp
	UueWoBWXJgmhAxxZJbDltJvMEbBuiTjtK+F/MeWcjuF4gubumkmh57uSxH+MX7tl
	vZz6R+KGE8WbZmx+q3oRl+rQj4GSWwpIeULX1PFCku1MK3ZPZN5d8irum5GMz1dy
	OoFPCwDT2JNDfaUy395rlFi6j3RpYpHyYRdrJdOgpy3JiuD2dmOCdBP9vk85cPzc
	RIqY0WvNdBK2xRW+2VAxM9ebWX2Z97SDc3x1/+prTV6v3JbpWM4j/7UF8NkcrRlr
	XLYHEMURqdiCPlZR5n5IKrFFaB5sNZGm1LFBo0El16giNTPDBmQowztDnvJkJsrI
	fWMccQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpergamtn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 21:10:53 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc2229450b4so3326364a12.1
        for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 14:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789420253; x=1790025053; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=p6Z+iVYBfNSCWeowkj5JZHLt7Ogk7p4zAvjEwB8LuWA=;
        b=LElZwKX0EU25oZRpvmJANbuxzlw2yipxhYZiYGolundHyoSm7Ul49HPVRdIvTro6b+
         AxqScdgqNi7F7uVxeeNb4MKGN+xrUweG4rpA6C1C/Uv3rkUGQ9QhsA65IRUr6B+E5DA5
         gt5sGgX7j1NLtcw2LMGfzfKhQxm5dF0EoSQs4LxgCsSEw6Zv++sdfm8Aya6bhRjuRT8p
         K2ZPuJPwhAl0gRE5kcPZKAUOqtYe5oYhoTFmovXFFvY5Pf29MqKjFLhEMI91sMaDOixJ
         XgJD8cX1onPlWfMXAwns9GLbUwzKR3kQ3LwrVQioSXPOnCdXFkY8VCcQTGlG0DlVVIzL
         mDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789420253; x=1790025053;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p6Z+iVYBfNSCWeowkj5JZHLt7Ogk7p4zAvjEwB8LuWA=;
        b=o3V2vYD+UtDnLPNkUQI0flmKKuNv5G9YtmCZZonAOZchA37cuAv7MwyStnh17Pw3pJ
         TNGSNN6/w4dxAIc6LzE5BBjVQk8UVew46u34GSIih5CBvdQzF+f2AQPtVvgwu4JhiDc2
         eOTtqY7DvWuhgPuPvVWade27kfiidA97qk7/6ilwqOMYmX/1AII6+wnmW4NOqY/Il+pm
         rbs1YuQkrzc4JgjbIR1vvN+VLbrBOsySAMi+lY70OMUnmdAVbmw4GoB5kkyDj0gNczV1
         bM/B+XwodLxsI1ABMh2RmJf++LKYGb3hZHqhRjG98mUjzQn8buvIVBiu+m4W3dBr4Kg2
         u45g==
X-Forwarded-Encrypted: i=1; AKwUvBzZTy1foyiAlBXxT65sYp8CKi+ejahe7rIggjnzxcB5Qr5j+onfrhjzecoIERXPg97XsaXTYA==@lists.linux.dev
X-Gm-Message-State: AFuF++nzkBbT9ssvTidR7aaMRO7Zy5EsAtFyLvOEk7eqIAL1J+86T9QV
	BJiIHqp0I0UYwX5sem20DCm5wTfuo86JIMf5acyD0aqr5qqirY2qaqxgechyf99viBv6cajBrl3
	130tKP36+/yerTm98MDXyLf7633A+N14AZFXc4ZugriOvjYvy8EJTKwkcOA==
X-Gm-Gg: AYBFou3+4j7CSkJ6/Ir3ioNlIGf3HMIEeeveuefalASzq3PyCdZZgsh7ktYyo2kE7Ct
	eRaofgpu1no9kRh5xwyttF+wElT6gbvhI9nifWlLfbOSvL/QzxT6c6AMmsMRydvU7RxG8KAvgoJ
	E3AxMdPcpEN3JNjYi9Ji1kl07qh9y+XL6mANCv2PjaEdj5XREobupQt0JpshwAi5zeNF1/HdQdH
	gw3s3BbHPN2g3yfL0ot0V2MXxJtplv3BgD5wsY9t/9MuvslTM/N1K67QAl6vt9AOLoXhvO4V9TE
	xO+AlOpZmWaY+IvVz/2AgM+qz0pU5H+sUXglTJ4eow/js83xJr7LrIdKxa2BfoCl92WZL3hQd9J
	ZeA1oKGBhlyVQDep8Wun6WHmm08Q=
X-Received: by 2002:a05:6a20:7344:b0:3bf:6d96:ac40 with SMTP id adf61e73a8af0-3db40480717mr8952894637.12.1789420253152;
        Mon, 14 Sep 2026 14:10:53 -0700 (PDT)
X-Received: by 2002:a05:6a20:7344:b0:3bf:6d96:ac40 with SMTP id adf61e73a8af0-3db40480717mr8952794637.12.1789420252504;
        Mon, 14 Sep 2026 14:10:52 -0700 (PDT)
Received: from localhost ([50.35.44.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b347e6sm25355458c88.4.2026.09.14.14.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 14:10:52 -0700 (PDT)
Date: Mon, 14 Sep 2026 14:10:49 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
        <joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
        <kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
        <baolu.lu@linux.intel.com>, Jean-Philippe Brucker <jpb@kernel.org>,
        "Eric
 Auger" <eric.auger@redhat.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <skaestle@nvidia.com>, <mmarrid@nvidia.com>, <skolothumtho@nvidia.com>,
        <bbiber@nvidia.com>, <harsha.v@oss.qualcomm.com>
Subject: Re: [PATCH v4 10/15] iommu/arm-smmu-v3: Support PRI Page Request in
 arm_smmu_handle_ppr()
Message-ID: <20260914141049.000077cf@oss.qualcomm.com>
In-Reply-To: <aqSLsg7AVgqusKob@nvidia.com>
References: <cover.1789081084.git.nicolinc@nvidia.com>
	<cbe6e6f578af848f4efdd8d1050181032effae37.1789081084.git.nicolinc@nvidia.com>
	<178908564507.2841562.6430226716089872094.b4-review@b4>
	<aqSLsg7AVgqusKob@nvidia.com>
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
X-Authority-Analysis: v=2.4 cv=QK/91QLL c=1 sm=1 tr=0 ts=6aa862de cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=aNnz9XPx1a4JIXSYt2cE/A==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=Ikd4Dj_1AAAA:8 a=HAQNk-a_8tHaYfDPudEA:9 a=CjuIK1q_8ugA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: LMiCuZKE2cIlZXgLPJMuRrBUaay6_OF8
X-Proofpoint-ORIG-GUID: LMiCuZKE2cIlZXgLPJMuRrBUaay6_OF8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDMwMyBTYWx0ZWRfX9v7tSzR19uZa
 o3jGf52Z/vQ8WkZKsQ7mQ2v5FPq4gZKHGEKOCcTV34qgw6JMAW2RWRLQx0UvgYmrPGTm2rZy5F0
 qUfCkHEi2r/icGWZnIJM7Q1XVdh3FQPR18vlDPY2vNuEeTAPJNgWhayq7EIZPWcar279C9T7jOQ
 +vhPHjb3WRa9bAeAaZ+zNuMFhhrMSMAPkxDKGP7snziF9gCJ7VamSCswqVR80w5li4Njr0IbMLK
 ndJSQXkjyG9P3IgVNaUOTkY1VMKnkXRBlF9uXFhfnpEgDSEHF0Ttqf5pPvqa/cfuthxL4kN6N5P
 iBEpOq7jBgNyIySdA7sLaGVf0veuY+ZpqLaryJHcX4h+avHvpf9GP9+EsTu8ZDm+yzwmXDmdPhz
 XeamtsHZP6ik9MtJU7gCGx6XNYNl94tbAc9mzH4azJbzHmOPxSqwllA1emoaLeuEFK7ufSBhUgN
 5pceuIV0F2Gi/19oXUw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDMwMyBTYWx0ZWRfX7rvuXMcPkkZL
 t6ae4kZPmdQ3368Uf8GIOEr3sNlY9zryDWl2ztvWloHSLYYwyXs6P0THONRGJlNZOOrOekWXlzW
 N70RVqPnr4GO0adTO5+hDCupkRgtPm8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140303

On Fri, 11 Sep 2026 16:16:02 -0700
Nicolin Chen <nicolinc@nvidia.com> wrote:

> On Thu, Sep 10, 2026 at 05:14:05PM -0700, Jonathan Cameron wrote:
> > > @@ -2380,9 +2381,47 @@ static void arm_smmu_handle_ppr(struct arm_smmu_device *smmu, u64 *evt)
> > >  	last = FIELD_GET(PRIQ_0_PRG_LAST, evt[0]);
> > >  	grpid = FIELD_GET(PRIQ_1_PRG_IDX, evt[1]);
> > >  
> > > -	dev_info(smmu->dev, "unexpected PRI request received:\n");
> > > -	dev_info(smmu->dev,
> > > -		 "\tsid 0x%08x.0x%05x: [%u%s] %sprivileged %s%s%s access at iova 0x%016llx\n",
> > > +	/*
> > > +	 * A PASID Stop Marker (LRW = 0b100) does not expect a response and
> > > +	 * must be discarded before fault reporting: see the documentation
> > > +	 * at iommu_report_device_fault().
> > > +	 */
> > > +	if (last && !(evt[0] & (PRIQ_0_PERM_READ | PRIQ_0_PERM_WRITE)))  
> > 
> > There is a bit of spec language about case where there is no PASID
> > LWR=0xb100 not being a stop marker, SSV == 0 and should be treated as
> > a PRI request. I'm not sure what that means in practice but maybe
> > a comment on why that case doesn't matter. Feels like breadcrumbs we
> > might need in future.  
> 
> That's a sharp one! I didn't find any the practical action was
> suggested either.
> 
> I wonder if we should let it fall through instead of a return:
> 
> 	/*
> 	 * A PASID Stop Marker (LRW = 0b100) does not expect a response and
> 	 * must be discarded before fault reporting: see the documentation
> 	 * at iommu_report_device_fault().
> 	 *
> 	 * Gate it on SSV, as without a PASID that same encoding is a PRI Page
> 	 * Request and it does expect a response. So let it fall through and be
> 	 * answered with a PRI_RESP_FAIL, since iommu_sva_handle_mm() rejects a
> 	 * PASID-less fault, or by the PRI_RESP_DENY issued below.
> 	 */
> 	if (last && ssv && !(evt[0] & (PRIQ_0_PERM_READ | PRIQ_0_PERM_WRITE)))
> 		return;
> 
> Thanks
> Nicolin
Works for me.

J

