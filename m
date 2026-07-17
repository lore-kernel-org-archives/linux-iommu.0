Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8D13EDE69
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 10:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784285102; cv=none; b=V4k0mOCwaKyUMi/F7ds+M7pwgIOAneUuxsy1i8mjrc7d9rTEztxv/lvK/oVIItWf4ebvRYq3RytP+/ATPPCq+EqKNTF20VZIpY2nAP17/kRKWRdgbrpDPeIK/s/Lbdql80W/DiRo7TKqz7jEKbC5X53Pp3epD35KrUVCDRZaeVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784285102; c=relaxed/simple;
	bh=2pEd2PoX7gxj2uadPnEorYAgEq8J/PjNx7zkix44hD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bqXPwzUj5wFcdAPlaKut5UPMU4bY80v4a+SRjPwydKV5lbuvvBMI6/I1CGbaA2DD3QFPLtvfqT6HbI7YrMDSj2ZXlfauKkidnUua5uloRp0mhhY6GCFea+xr6s/kf9gcN/AbYBWuXJttFeVDBTptpYEtKtpkx5fqsKFfYQTmGyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=puxOJNuX; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="puxOJNuX"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c15e592da74so943258366b.1
        for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 03:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784285098; x=1784889898; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GHMjre5IwjmjoZwiytENVYpWI2A7IWIyRw+/ii0+cJ8=;
        b=puxOJNuXO5SI9VkteRcXyXeyvIZXTmjnMvcNmPnHglmiOSJApzZiGlEIHs1PUJ9yS1
         DRZ4iMSsraPv3x6LopHZt5xwHTtEPLCd9FDuEs25AW7gceylkUZ6Hu8EUajpqME5tWnW
         5NucDa1Hvy18saqTlW3ovTEEYWTBd0ox67ufF2NInHM4UGYyZ2s9ImCM37pndiZ5mJhH
         2DbYUs0lj+phu8NHK92h/yOpTdwuWV2ueC5jmzP9dx6AiUAjLEo5uh3SnYxrBRJf5jas
         Xv68z3gdMwdBXHlOLbKRchkS6lpIOFHbAWei6nVdJlaiMmpPqcXPSFWWGIiiQElY2mPf
         1H9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784285098; x=1784889898;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GHMjre5IwjmjoZwiytENVYpWI2A7IWIyRw+/ii0+cJ8=;
        b=LqFnQLmn+SK3d5QlvueGXP2j8ynDpaW0kNAkhlN/NrSUthv/FhXjRrfPoKtyPAQedJ
         VgkzGPJKS+8TjparFqe7UPl7aRq9Y6GLLTEazf3yKmu4/8+F4E8dAbbXrs5LriOHTVsp
         /ju+H9AP8HMuVaOmQuxa6ppEJn7aKYpJU5jHEATt3Lp2wbu82aYYz691MrEzjZgwJ2u6
         3m5Q7K+zwNYCkJtzoEdnuxoUtArZmoG4OiL6NT9wqL3aGhYZ7qg2A+1HKl4PPKdsYu4K
         fY1nBz0UigcjRlylMoMnkTwiMLISc5Y+m1gFeXsCB9ryRXSmP9Xk3k0G2chLA3IWfjv/
         +Kug==
X-Forwarded-Encrypted: i=1; AHgh+Rovqo0BBuVd/09xVBHBsKr3j18EnY375t66dLGjAEh2IOBXQbm8CzqVhb3sCFmCdCdjlOJuiA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1U1H4qFtSXJxJeTMRxXst8vV2tJpZ82L2y5r0xVI/U8s2xoOl
	C+Q5EqUj+DFt8gZOmTZaPasAGYgI24C9cyhvWF0KWFyePenAwuiGtsn3
X-Gm-Gg: AfdE7cmvgIKj7j43bfkw8EqwWMnTGQvdjBl0i29Y5GaxTEwC9VekFjI6LjTEeHpYrcO
	zOT/9IF8Ofwf9uE/2+nPFKE5aIkX2aOpYTr3SFBs9lG1MX3DEtx6+oPc8oGbobAQ2wnOKboLyV4
	3HP2DtBUKxSy5Xa+NfEiYVA08M6VP6iXEJ+rlcC1mrgM/yOEj6v7yTIpap9fozaXtcI20tJEDAr
	bdr5ZWqJ8u0ve2UyL4XBcXYCm8T2ksDEOKSQ3kLaN5yYRQDWLtv0xrnuzFEj36S4WHJ9OzzTeuX
	7kf/lkpQ+LnAcUTQN056ZxOGOwds1GM5wKlBx+AXUqq8i4zVsMXjuDZUEa5Cja9V18iRhi2vmz/
	2HowYyztHzWo3jOnMdkzcpLrwbgcwMjSqTuU3hPgXxIzdgABYqt6gG76fqqxlKouROmRPi1jgzp
	yKO+WmyPcYxCbj3g==
X-Received: by 2002:a17:907:841:b0:c16:66dc:3abe with SMTP id a640c23a62f3a-c16b46fe83dmr88156066b.28.1784285097922;
        Fri, 17 Jul 2026 03:44:57 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1740bf91bdsm52739366b.63.2026.07.17.03.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 03:44:57 -0700 (PDT)
Message-ID: <dba037fa-0f21-4a50-8727-076a3b177c47@gmail.com>
Date: Fri, 17 Jul 2026 12:44:54 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-iommu: Introduce API to reserve IOVA regions for
 dynamically created devices
To: Jason Gunthorpe <jgg@ziepe.ca>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org,
 m.szyprowski@samsung.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, dikshita.agarwal@oss.qualcomm.com,
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Robin Clark <robclark@qti.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>
References: <20260119054936.3350128-1-busanna.reddy@oss.qualcomm.com>
 <cfd23f75-8952-4463-abd5-815b995031b0@arm.com>
 <bb59f07e-ca7e-f012-6a4b-0a148350b69c@oss.qualcomm.com>
 <20260612172649.GM1066031@ziepe.ca>
 <da77c21d-25b3-46c3-a48f-71f0549e9f5f@oss.qualcomm.com>
 <20260615125257.GS1066031@ziepe.ca>
 <dcc0d02e-91fb-ddbe-399a-0191bab94c4f@oss.qualcomm.com>
 <20260617194038.GC231643@ziepe.ca>
 <e9e76c9f-b3b1-4ffd-9547-183556f6bb60@kernel.org>
 <20260618151745.GD231643@ziepe.ca>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@gmail.com>
In-Reply-To: <20260618151745.GD231643@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/18/26 5:17 PM, Jason Gunthorpe wrote:
> On Thu, Jun 18, 2026 at 01:57:40PM +0200, Krzysztof Kozlowski wrote:

[...]

> So, if we are going to do a hack in DT to accomodate Linux, I argue to
> choose explicit child devices so VPU does not need to create a special
> bus, call of_dma_configue, or hack in new DMA API things that only it
> will ever use.

Bit late to the party, but I'll chime in with some more "amazing news"..

All of the multimedia HW on QC platforms (camera, display, GPU, video
and their specialized variations) has at least part of the same problems:

* Multiple SID groups that need to be accommodated for different purposes
  (normal vs secure buffers provided by the same device, different
  "logical functions" generally speaking) apply to all of them

* Different IOVA limitations per SID group seems to also concern at
 least the camera uC ("ICP") (but not all of camera hw)

* Remoteprocs (and therefore also the audio stack) expose a number of
  subfunctions, some of which we currently model as subnodes (although
  many arguably only exist as such because someone decided it was
  convenient to express them this way). This, for example led to the
  representation of each SID group associated with the remoteproc
  (fastrpc/"run compute on rproc") as a separate node:

-- qcom/hamoa.dtsi
remoteproc_adsp: remoteproc@6800000 {
	[...]

	// no iommus OR iommus used for another purpose (fw loading)

	fastrpc {
		// no iommus

		compute-cb@3 {
			compatible = "qcom,fastrpc-compute-cb";
			reg = <3>;
			iommus = <&apps_smmu 0x1003 0x80>,
				 <&apps_smmu 0x1063 0x0>;
			dma-coherent;
		};

		compute-cb@4 {
			compatible = "qcom,fastrpc-compute-cb";
			reg = <4>;
			iommus = <&apps_smmu 0x1004 0x80>,
				 <&apps_smmu 0x1064 0x0>;
			dma-coherent;
		};

		[...] (there's a lot of them)
	};
};

There may be more hiding in plain sight, but those are the ones I'm
aware of.


I was kinda hoping there would be more buy-in to follow what PCIe
does, but to my understanding you're opposed to it because "vpu_bus"
is not dynamically discoverable. PCIe generally obviously is, but
we already have prior art regarding hardwired/onboard devices - many
qcom DTs carry per-board iommu-map overrides to please the allocator
with known-in-advance BDF values (because the HW has only so many
SIDs):

-- qcom/qcs6490-rb3gen2-industrial-mezzanine.dtso
iommu-map = <0x0 &apps_smmu 0x1c00 0x1>,
            <0x100 &apps_smmu 0x1c01 0x1>,
            <0x208 &apps_smmu 0x1c04 0x1>,
            <0x210 &apps_smmu 0x1c05 0x1>,
            <0x218 &apps_smmu 0x1c06 0x1>,
            <0x300 &apps_smmu 0x1c07 0x1>,
            <0x400 &apps_smmu 0x1c08 0x1>,
            <0x500 &apps_smmu 0x1c09 0x1>,
            <0x501 &apps_smmu 0x1c10 0x1>;

Although it seems to me that it's more of a hack than anything else..


With that in mind, do you still prefer that this is handled through
separate nodes, presumably for all of the aforementioned cases?

Konrad
