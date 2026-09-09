Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677873264C8
	for <iommu@lists.linux.dev>; Wed,  9 Sep 2026 18:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788976877; cv=none; b=Wj07snzINsRQsJsCTwgoIeiFm83tZK5erV2i97Th34wunGOKWbyuHXu932c/N452fZlbYOiYKaTdBTuHoqGQ4tJWqZThgErS8ES+Cpy/LvObfJxFcRSU+QgeIq1S+Yb4jff/fkcgRYMazENcZF/VarJqH3FQAiiPrSU3GM+FApo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788976877; c=relaxed/simple;
	bh=MWAcc0S8T0AMmFdPD+A1IyzlpMsFTMKOibCCpP727Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P/6RBpAN9zfcqfnhmqiJbYrDyCcM2HnVSgYWeoktlNbnmrRWM2iSiJK/a59Oq0BGLMuPGuIkfhExmeoOnfi7J0pIuU0ywqUvYYngwvbysndbrMNMCbHMyvSkxSQ0H3AH/KeMPseWkz3avD9jLHJc/+C0NKxOyArq8dOT2C2O0lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kVXwzG0r; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g8P2cH6a; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kVXwzG0r";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g8P2cH6a"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689H7cIP3133881
	for <iommu@lists.linux.dev>; Wed, 9 Sep 2026 18:01:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BvCuCj+1hsq0hf2yMIZAP5CM6LznakfZh7U1V3Cg3gU=; b=kVXwzG0rArK5FzXu
	IsAToYikSvB46NCL+MJV9WEUbY+uXtNRkuT1IyYz45OB3NY0IzgjLBAiZhr4UmBw
	FiEwVh+Za3t+/7falVzFeotH5bAiNlJfTBKjOVC6pW3knTU8R9E9jEWefKIzx/SK
	8UYSDgwUx7gSi2RiE0D3n+ZmwqGnPvk8C2pCw0k9GbgCBHYiUz+AugH4ovuOup5t
	uHKzskCJjrIaMO/oERxlm4qPOCDnta23QmGkbl92DRkq2L4Q3rB3QQu2vkG9YSgN
	1cYZjxlJWL8Z5gNcB5kioAFg1JW2xFndXlUX5rw39v3PEQRAo25OItMhmNm19uQf
	/QJ3bQ==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk5ru244n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 09 Sep 2026 18:01:15 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-46524220c5aso7623564fac.0
        for <iommu@lists.linux.dev>; Wed, 09 Sep 2026 11:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788976874; x=1789581674; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=BvCuCj+1hsq0hf2yMIZAP5CM6LznakfZh7U1V3Cg3gU=;
        b=g8P2cH6ajPvMDDDftK+JNpGM+O8dbrDnXzofZ32GxkewOMUkT4FtP9S7AtuALplmFL
         J7Chqw8/7gdKij8CM1Op1aoej2jVgeGJXFRy8wp+NJf0hSL14WNWsD3G2CDCKcNfXF8K
         xs1NhaMHvq7bzMZj5Ln/wGlWLz7rQtHIAuoYmZo4D5vYUlqMbV0zDEcKj84i8EZHjb+v
         Nubncnugfo5N6Lvsz3eoepAsdUpD6l391/xLJwRZ7X4oUVZYTdbeOrm0DwZrGyhLYfDx
         37Q31w765aK+FO8g1wsxXHzkz9qM5JMeeExumePeVZxADwFw+tQDLjhlvunJKmvop9/G
         87gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788976874; x=1789581674;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BvCuCj+1hsq0hf2yMIZAP5CM6LznakfZh7U1V3Cg3gU=;
        b=dE65w7aN9YfWSIE6OkinXU/A9IcnlhBdP5ylgJlkaVxPccqKomrT2GhA7oHG9n6jaJ
         99QZJUM4fYfHRChWN8n+/qGlt/ebA7G0yzDYEMc1ozqF+znRn1Afp6KEfT/NstzqUUTH
         0xZRm9HNRSIV1MYk4ZJueVyNL74ado3sQzfodSX8YUr7iwOXVTdZhPaIi4J1KrbzX/kk
         jZMaWRZc6KJka7ANGckOXv16ytry2CIYmUXglLDr7Dphxlf+dRZXLfh1odt6jUSvu78x
         NSr4TYZNYY4UOZN2/jn7KDp+rmb0G6i+oibxfsMpRedU0yFBFNQqo4ykiPCUntnTc1Pm
         N1ug==
X-Forwarded-Encrypted: i=1; AKwUvBxYA/XXFWTkKBDNNauwNbZYJcS0jFW3f2iuC9uNCJ9MSHdgoLiQRWuZT6aQ+O5n20ma9kCE2A==@lists.linux.dev
X-Gm-Message-State: AFuF++lh6bGEWnoIujRjrw/MQLXa3Id1XGTzXjz2WAmjGPdbaHs3/tif
	FW8IYdqolxElQ7hGe3Q3apA5sVDDP2ZMzFo3ZF7DPI0f+JuMJnXfdveSgg88v/3JEOP8S5mh9WQ
	UI7WIyTFUhRIvIudBbDHrjoWwbWAl5pz1IhaYSG5NOb9YaJnnYo4J9rVUBg==
X-Gm-Gg: AYBFou02kZmAbGpOCt7QLXAywNAsfN/Z4dSibutgmAeBNbwzInfzFsR1I3AFOt6zVJV
	t5h3LYAxE42F4mjofd30GBsvY7WKhCYRwfz3v8C62fq/gt8TovcyRtiEIXpdkTYJR1OUDjGOSkX
	bI9smgl/ZkpTLLDzaPi4Lhwq07Xa5r5pl6tgHEWj1mw5S8gHG5BKFv4YVoy8ecC0Fh367sIuIKB
	UcPvnDz3yPuSa925iY7qdS2OiTODtcqrLwk92NYSIST0H0VKUyF3VysIMyRlcdPev2EW7PNvjvu
	2Urg+lAvrHKIuLAIYVg8tlux1DUCV7wBipwym1IbCQftbKRh7Z0I4W7+sB2RJna9yEn6w5GX7rv
	/ArLJcfFfVDf52SNi/bJJKgdfSuw=
X-Received: by 2002:a05:6820:4df3:b0:6be:46f4:2908 with SMTP id 006d021491bc7-6be46f43c91mr2959533eaf.55.1788976874245;
        Wed, 09 Sep 2026 11:01:14 -0700 (PDT)
X-Received: by 2002:a05:6820:4df3:b0:6be:46f4:2908 with SMTP id 006d021491bc7-6be46f43c91mr2959494eaf.55.1788976873782;
        Wed, 09 Sep 2026 11:01:13 -0700 (PDT)
Received: from localhost ([50.35.44.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1435c2ae6b5sm280583c88.1.2026.09.09.11.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 11:01:12 -0700 (PDT)
Date: Wed, 9 Sep 2026 10:59:54 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org, robin.murphy@arm.com,
        joro@8bytes.org, bhelgaas@google.com, praan@google.com,
        kevin.tian@intel.com, kees@kernel.org, smostafa@google.com,
        baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, skaestle@nvidia.com, mmarrid@nvidia.com,
        skolothumtho@nvidia.com, bbiber@nvidia.com, harsha.v@oss.qualcomm.com
Subject: Re: [PATCH v3 08/13] iommu/arm-smmu-v3: Disable PRI when no IRQ
 handler is registered
Message-ID: <20260909105954.00002181@oss.qualcomm.com>
In-Reply-To: <20260904141525.GT4157646@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
	<0b5282c7e850f1a1c650e43670899b4ef5335efd.1788222486.git.nicolinc@nvidia.com>
	<178846311318.1308030.4956293524348641228.b4-review@b4>
	<20260904141525.GT4157646@nvidia.com>
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
X-Authority-Analysis: v=2.4 cv=M+997Sws c=1 sm=1 tr=0 ts=6aa19eeb cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=aNnz9XPx1a4JIXSYt2cE/A==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=Ikd4Dj_1AAAA:8 a=nKlBY_KgISjqlfJ5XcQA:9 a=CjuIK1q_8ugA:10
 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-GUID: PxbxV49pCea1yzCDJ_HS-_BrRU9gLAiC
X-Proofpoint-ORIG-GUID: PxbxV49pCea1yzCDJ_HS-_BrRU9gLAiC
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDIwMSBTYWx0ZWRfX2shmPjqLOVwN
 oVLF/Homyfhji/huaC0EK97jqfr9EA8g1c6eyvtab7ZEpYGMX3FCp/RLpOdPo3lVdn11eVq9NYD
 gQ+P9Jw5AS9DJORLOHHfiiUEXLa5IK8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDIwMSBTYWx0ZWRfX+TsBPijC6W2F
 cm4TVBtcXr0OJsoF4VyxqE7FdpsrgIFoZm8gX+Uo0FZeq4ZZCKzF19qmXgsI+gvpy8OzAxEHuXr
 tdd3M4vADtshCZC44k4cIc1/kSt0bNYVptZba6y6UGZqDdzA8uRPFr1+Ea7SCWxebWs3wvYs0vl
 7A/ABuf0rTanjm2i4y0z9RjlVFyX4Jldow1tEzK5iZirLbeoo4rqTz/VJT3sLk8smOy4L4OGSgi
 N8XIz7ie83Uz9GmiRJzJnFisGmhsJpxgyhijQIsHKeqKnxULW8Zut0Qh78PQtp+1xoHaqgLuQB7
 2z0gSymqQaRN8ICUIOLXAEMKIVJsjn2WzAebDeva30+euudGWWhs3MXtJBOvSBjmGUy7uEZJxQl
 d54qzgTZ8JOtHc+RuavbKEa08nPyiJSZZ19eTr0hD8HDyXraAeffbB7zZNlSFab6h7mvbf5sWEb
 cv+ZMx7Y3uIaGHsPGXQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609090201

On Fri, 4 Sep 2026 11:15:25 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, Sep 03, 2026 at 12:18:33PM -0700, Jonathan Cameron wrote:
> > > arm_smmu_setup_irqs() has three failure paths that leave the priq without
> > > a handler: a missing priq IRQ line, devm_request_threaded_irq() failure on
> > > the priq IRQ, and devm_request_threaded_irq() failure on the combined IRQ.
> > > Each path warned but kept ARM_SMMU_FEAT_PRI set in smmu->features.
> > > 
> > > With FEAT_PRI still set, arm_smmu_setup_irqs() enables IRQ_CTRL_PRIQ_IRQEN
> > > against a handler that does not exist, and a later change would then have
> > > arm_smmu_probe_device() call pci_enable_pri() on PCIe endpoints, allowing
> > > them to issue PRI Page Requests that pile up in the priq with no drainer.
> > > Separately, arm_smmu_device_reset() has already enabled CR0_PRIQEN before
> > > it invoked arm_smmu_setup_irqs(), so the hardware queue would stay enabled
> > > regardless of what setup_irqs decides.
> > > 
> > > Clear ARM_SMMU_FEAT_PRI in all three failure paths, so that subsequent code
> > > treats PRI as unavailable. And disable CR0_PRIQEN after the setup function
> > > returns.
> > > 
> > > A kdump kernel cannot service page requests: strip FEAT_PRI when detecting
> > > features, so downstream PRI setup is skipped.  
> > 
> > Dumb question - why can't a kdump kernel service page requests?
> > I'm nowhere near familiar enough with that stuff and I suspect I'm not
> > the only one who might be in that state and reading this series.
> > Configuration choice, or a fundamental thing?  
> 
> The initial issue is the streams are left in whatever state the crash
> kernel had them in, so it can be generating a bunch of PRIs with no
> place to put them.
> 
> Though eventually we may find a device where dropping them is not good
> and they need to be NAK'd promptly..
> 
> But I think the real motivation here is to save memory in the kdump
> kernel..

Got it, so design decision rather than fundamental.  Maybe tweak that text
to say 
"A kdump kernel doesn't service page request" ?
> 
> Jason
> 

