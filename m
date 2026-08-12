Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9F2437847
	for <iommu@lists.linux.dev>; Wed, 12 Aug 2026 12:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786536764; cv=pass; b=IPXpguCHwUdbdtJe83sBa7jnO/NdYjyUGpHECCHZ2xr7VQNFaqoUTr7XXI816No9IVuY5GhTVtuP+x5KFzTbGtqQ9nCFruMNvOOJvJdilMBGKHBMMjOu7dGNjzm63nD9wOrQg8iqlNh7IWwQkHV+qEoIiYMmgxJQ50CGbFFfrno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786536764; c=relaxed/simple;
	bh=iuG8ZAS+9aPT26tPIJ0DU5HMUWFYLsvkm5izzc1uSKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PUKRe478PD1BZSmewiWkU9ZHwy8XJmdYYQwmxn7qtTTv5zy41+CS1iD/kCHslCPRbAVz2KGShM4oLjdQp60A2UARI/WPespElCvbvAJHZt6nQlktmBmagsyjdTf+Q45YK23N0bm1X8J8CfJS+msg2GHe/szzXJ2Z2ZkM0iIWMPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pvSU6kSO; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pvSU6kSO"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6a0794669a6so1639527a12.2
        for <iommu@lists.linux.dev>; Wed, 12 Aug 2026 05:12:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786536761; cv=none;
        d=google.com; s=arc-20260327;
        b=S900g+jzjA+ewbnq2UR8bs406Qvma2pESf9pQfKLEHODolskpdVDdNN1+gRi3w9y4T
         wyY42ib/WtZRWmTSLuQHmbHFUXargqBPR4jBj2jEmn8LqxhP+MbB51t3dpweXAAnzhOg
         H+8sw0ExKOClha7yshAyBVZDejqcKwJZEM+RwB+xlNR/gGXfMqUaQQTfTcFd975K0fXk
         1xNoAOOAFj8zoeAGMQUo7REnY5ft6wNVFEigucWeCzXd4KoFQFfBDer0o5/vHJOlXPYk
         A4DKJlzCliimOQRqcuzvXESeqsUiTpUmrbdAL2zM5C4o4qs49r6yy+so9gpyvXGMh4nE
         +aYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=C25d7u206gAS9PBJlhUuN2Ycn3eHUVpUH80KlaH6guw=;
        fh=FZHCx2/7o3Ghfw4Qxjksb7mTWntHNRKB+9GFdRu7gBs=;
        b=SgL3G4NjmuhtreHudUWDaDgmCykc8nDSaUvmgUDgnAjI8Oz7W94R6WOFfwQyIC38OV
         Lm5UPWWsePkI6gvx2Pp/tprkUBQNd8qBtwL/BO2hfIntD9Fko0wOYMyzg1cqvbfwugSK
         aLnwBRYo8fj0RPaSwyK9TAcUjGbBziarz8BLwVL/OodYMs8aAPIOsYhrjA53zj1bDPD0
         6OT6Izx6qxCx2sSTV9fZMV8DLT3KmtbEYnExF6fqpM+ktRMVhIm7U6YHfDfHG0stouZE
         IKCxn2d0L68Z0TTp2pTjfPRVQp5sXNjVYSrhjgAdFF3kbDJRnh0rZ6mjRHc/9PsaOhGn
         8bBA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1786536761; x=1787141561; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C25d7u206gAS9PBJlhUuN2Ycn3eHUVpUH80KlaH6guw=;
        b=pvSU6kSOkOzIPQ4OJG30d6o15DF/5vlyBJy7b1me0ZNfRrWm5I2JhGPN/zxyQiIgIj
         3IdMXPfMrFZuOG32Je/As539XUpV+yFbfdJsW5cq2drP2IVfYwkO64HuUUqbufLQnAvc
         Icl5Rx5itEhSDCbZwo8QFsMrrTG8j+wYpfpmZSgqgTpQeqZBD4Goz2WT3o61XdlUvgXW
         26YzCq3zBbzrs7abziJcnpuscygRu/TgpXtWR+E7HQ5vbg93CQ7EpmQIDaw7hZa4f08f
         dgTclHDV7D9/6AzGGXrKKlq+LZw4/sAE6dkqXfGn9pvWZnnBTHDW7OSoXlCJD9E5UR6Q
         cr7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786536761; x=1787141561;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C25d7u206gAS9PBJlhUuN2Ycn3eHUVpUH80KlaH6guw=;
        b=nsUzHD5VhCG3VwxdJevKEih5JeV0AM3ZP6O1We81qn1BUmLkp9dtQM/a7Ef05bNwC6
         TTXdspS+fc9BJnKHpef48WhEXT7SuoQ9WlOp/PfdmjrpJrJf1arO2zlhUhsQtLPubHFe
         ufsO141mS2qt7PSCjmXKGCbsTbs9v7/faCIgUAsQXeB+Cn44Da3qY1FtPg7NsqBEQOj8
         PJM6t2GaMmzbpKqrGzgxQ7S++Tnr7Tsh6hCCes9yYJL6/B/dkBul4KaLhnIsCn7UWFz5
         kiAYBpb9C0DcHL3IXzvpj7fcDX1r7pR7jeLp1xo1AUqhAZgA5Z9JcMdzXmVcwOrWzktz
         lvmQ==
X-Forwarded-Encrypted: i=1; AHgh+RqJKnvb57jPEGR4widHxhlEUT1tRKiLUxQC9z/JlArC67Udbmpl6Mjl7eLa7uMxEFOADtH3lQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQvzXu62H610ydetD9xpTDqkoOqri3RBVpLnvXw0yYTKvaI+cg
	OeWamwzkxCC9pnLe7EvhKRCs2xfzTVeExVm6avVWEnu1zISOS9QJX8w0VrAX4wYujW7kARGcctx
	FZpzXbPzQMTHeZEvTtuWY+H2j64kBq87p9I+yjAoxBQ==
X-Gm-Gg: AR+sD1304cYKM7Fk1EvECQ5fX+au/dAblCH4xGozVH52NWbKeaQ8WpM9Dz8LfC0crQM
	vHy641K+BmEVhHj+VrVU44UZrGFxpCzD5cxIX0qeDkAvXsXyfExfTfQ/qY23yfDJn5VLbCakp7q
	R7PC5Tdu90g6feoENGTN+VmpfWnJ3TOyclZyEZV98MY80jk08AyCWR2XofF/kMnn3W6FqIJK8ur
	Bu7cLiIPKYaNhIUTSzGNE/amWH47Ty6ODCcU1op1aS88hikKIsr0ZRCxFt9E6G6qQ0IxvpW8yP8
	X8DNzdtIntkXy8QSU7mdkFQ5R53FyQKgNpFJY9dQAk8e6SIZpyzzu3kj4EuGSISf6tlAy2iH5Aw
	Wkw==
X-Received: by 2002:a05:6402:5415:b0:6a1:df2c:cfa3 with SMTP id
 4fb4d7f45d1cf-6a375eaed7dmr1884024a12.4.1786536760363; Wed, 12 Aug 2026
 05:12:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260724-arm-smmu-v3-instcfg-override-v1-0-e7acf4a8a525@linaro.org>
 <20260724-arm-smmu-v3-instcfg-override-v1-2-e7acf4a8a525@linaro.org>
 <amOpSPmc36+YXgCQ@nvidia.com> <CADrjBPoOctsStZn84vtCymdKen2R9XcM880=wxXSv1tpQ5+vyg@mail.gmail.com>
 <20260810141553.GP200537@ziepe.ca> <048c8d59-d47d-4f64-b93d-3b041636e230@arm.com>
In-Reply-To: <048c8d59-d47d-4f64-b93d-3b041636e230@arm.com>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Wed, 12 Aug 2026 13:12:28 +0100
X-Gm-Features: AUfX_mwXOifN2coQLoTdXQNBH4WeSdADhQh1-gynQzc7tMiJ7JxOqAB8IwzRDWc
Message-ID: <CADrjBPpPqLaq75G4Rzxmf2VEwyZ_gwchf1f-jjzr3EXLkXaWsw@mail.gmail.com>
Subject: Re: [PATCH 2/2] iommu/arm-smmu-v3: Override for Inst/Data attribute
To: Robin Murphy <robin.murphy@arm.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Pranjal Shrivastava <praan@google.com>, Daniel Mentz <danielmentz@google.com>, 
	Mostafa Saleh <smostafa@google.com>, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, 
	tudor.ambarus@linaro.org, andre.draszik@linaro.org, willmcvicker@google.com, 
	jyescas@google.com
Content-Type: text/plain; charset="UTF-8"

Hi folks,

On Mon, 10 Aug 2026 at 15:43, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 10/08/2026 3:15 pm, Jason Gunthorpe wrote:
> > On Fri, Aug 07, 2026 at 03:37:37PM +0100, Peter Griffin wrote:
> >
> >>>> @@ -1222,7 +1224,8 @@ void arm_smmu_get_ste_used(const __le64 *ent, __le64 *used_bits)
> >>>>        if (cfg & BIT(1)) {
> >>>>                used_bits[1] |=
> >>>>                        cpu_to_le64(STRTAB_STE_1_S2FWB | STRTAB_STE_1_EATS |
> >>>> -                                 STRTAB_STE_1_SHCFG | STRTAB_STE_1_MEV);
> >>>> +                                 STRTAB_STE_1_SHCFG | STRTAB_STE_1_MEV |
> >>>> +                                 STRTAB_STE_1_INSTCFG);
> >>>>                used_bits[2] |=
> >>>>                        cpu_to_le64(STRTAB_STE_2_S2VMID | STRTAB_STE_2_VTCR |
> >>>>                                    STRTAB_STE_2_S2AA64 | STRTAB_STE_2_S2ENDI |
> >>>
> >>> This adds for "stage-1" and "stage-2", while missing "bypass"?
> >>
> >> I need to follow up again on this point, but I don't believe currently
> >> we require the override for Laguna when it's in bypass.
> >
> > Oh? Why not?
> >
> > Is the issue the IOPTEs are set to no-exec or something like that?
>
> In general, there isn't expected to be anything in the memory system
> downstream of the SMMU that makes use of the Privileged or
> Instruction/Data attributes, so I would assume that is the case on this
> SoC. FWIW, hardware folks would be quite keen on relaxing the
> architecture to say that an SMMU isn't even required to propagate those
> attributes at all.

As Robin mentioned above, there is nothing downstream of the SMMU that
cares about the AxPROT[2] Instruction/Data attribute. So it could be
added I guess for consistency reasons, but it seemed better not to add
any code we don't strictly require. Maybe a comment should be added to
_bypass to explain the inconsistency?

Thanks,

Peter
