Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB78748124C
	for <iommu@lists.linux.dev>; Fri,  2 Oct 2026 22:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790981153; cv=pass; b=VJkovDQYtbXZ/uWcdslnHM/uZ2YKkPPybaGEh1w4x2tR8VVDihbFTlP/C4RMmDTgBdP40SvP4SvEFYEdK0OhrD/77rbR2765+G3xUXrthZCa7aueCd9a1DQLDc5gwbYsYSbpYZ76ODwBmFQO5BCpaZhDJJh1/8Gdw0LFR2WwVHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790981153; c=relaxed/simple;
	bh=b6tpnWqi0sBgzEyRHL09Bqg9b7O7aqDdleTKkCbYmwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F5Ke8AR7ZBaeUaDT5R1QT/Ikl4MSPk1QABLg/jiosjX9pMH6s94CPeniY5rg4n2yk+CnX2WHWLLfGpv3NRJeWZAw1E+ZvBTbvMBPy8azZSw/sHQzsmSucJfV6CxFcJopXdeEITlaDIuxin3Z07Wqepnj3gjVwb8NZZb2Lf3n9II=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CYx5zdK8; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CYx5zdK8"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-53113d72966so40581cf.1
        for <iommu@lists.linux.dev>; Fri, 02 Oct 2026 15:45:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790981149; cv=none;
        d=google.com; s=arc-20260327;
        b=Gd2gVREwwXZtmeKXLXf1j3sOWfTv9zUIxqO43oSR9UgJHSAy6gDmrm57SFGQrko5qX
         HNkTgKXonKa6Qvk04QnP3JJ3QdzKaHw4abgHQ+8VtDLCMs5HqBfiK/x41oTZztPZ+mqe
         XPh94xiMR9/V1tddv5Q/19IRiMOh2RqdL3g1JrUMLy/57yUGMBf5GiL+t8QLZVmO+f4N
         fg6Lmm87wMqSb/dIZf7qxGNGZz8iqq0TCGn/9xZBeX048perVlhzlFUZN0GPIMwSgZIN
         at2zVBlCn84dRm58jbpDXXUnRSqiEmruJupDJ6XKGZMGfuurFodzc7Tl2p2uC3Ye+hJm
         EE4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4ethMyS6aCMQkVyOx2GRO0J5eXro8MDvqsE/LBxA2QM=;
        fh=7qafrwt2OuZhLmSOh2KDnxX2wzOs5bw+CIm/6b9rWFQ=;
        b=ouIw3FmiYFmVphseAdDyryUakHUDVx9eU1vR8RcUBxUM11T6txIPvqqg6JoJ7NLhgE
         FMQxPTHaTvj+3iLhi4Nau+tN/yr/Zn7ffz6xPCvqiEdlGlbieZ0YH8AryalWdjQLvl4q
         IkKfZLrbArNL0y4iQMnGVt7gkI6rL7CCoRGNlfud9+b0eUjam9LRjSmVK4JFmhMeh8q4
         O3sx/7laREtJGP3mgmTiClb41cu+N1QcuVvcioz+CiuFVXAK00HEIrEKk4UMt+Z4T0BI
         aSYUJQkySlpYO3q+6J6C8+zH9tZzupxzgTkyqsLe+HSAWLjCDQ8EefnvPcXbF3WykbX/
         GU4g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790981149; x=1791585949; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4ethMyS6aCMQkVyOx2GRO0J5eXro8MDvqsE/LBxA2QM=;
        b=CYx5zdK8ISZvXoHSvY77TBd4xO3bIQJ3VbnA5R+2d8ACnxzxtvMnZ4UaZducvIKBTc
         +5rQzt53O6ioHq5tAsj/Af9lTOxD1fy1wXz6ku7al3Nau0UuuYRs6UQYGgeB/WwWeulA
         s4sgfLrhmZYWchaTWPCKvtdrIQ/u5O+GxWaMhpCyX46kKII6zx/aJ9zbtUGxKIABndC+
         0GaIzsgezA/Qr/27btB7xUSa+HPXSjHlFg+Pp9UzFid+JuNKa3JDfNSO/MXq8b593Tsg
         9AratuCOa0YnPvo8Z5CzKUq3hRdHHL1MCwcwxZNFpsbGSTpSCPS5q1sotdBRbPMaVycj
         1f3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790981149; x=1791585949;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4ethMyS6aCMQkVyOx2GRO0J5eXro8MDvqsE/LBxA2QM=;
        b=EUt2WU8Lj2jy91G13WoXv3Vb7s9Q4m/E8ZB9Aflbqr4gB6/sFWaZokPBSWi5WHVqet
         SjIxB3M0+dqvMFjCk+KsD2RDfnGlcbQ5wce1YWjdh9CCsBQ+pKCM9GbaM5hDDa/sm2Zn
         +S6wXOkR9CWDDniuY3aMS0k6wgcKjnTHOEtOp7KNlUmKSYLEDp6qJEgKplV+CyqFpdOD
         qst92FUoCpQk1KqNFp5LT3aDOkiLFpInlDUtkqpEaEwW6RFMzlI2A+lAm66EHuzc2ypF
         51/OteKYpiN6pu9KoOGuC9S3RJKkjzeOu9MUl3mKK+gkiymGoO1uk4s5h6Duym0vpWRi
         k8Ig==
X-Gm-Message-State: AFuF++nwgOmCre+6NE+VYfl7HG6s30fEMLz3nWUPOJhRwI0hqxtap6qn
	HZHM6mW23C4wZTJodfWn15wtGfvhgfNivl3CzjAYvC5ST5GLB0l+9JPeUIGHrXZ8NNHJyhrOrkU
	3HmyyRy+JeuAq8sC1QBxdHqub+2lmPV4v5d4dvuXi
X-Gm-Gg: AYBFou00pt5Ov3Vmk/2U4bTqGnzUUyaW1SvEauoGOZtiKpAZ/bEPjYzoJdPjyTbiSm3
	OihfzJvQgugY6MGOLMFqWNWUxXg2+9MCPLPyTSTXKfCfoMixwJm25Za94ClLaKud6vgV91C2H7T
	HFFqaU99zg/b5B6ul4UojSkdRTu9sTNivsdmJGswemUrW/mVUevpxsh6fY3TkBHrnFFr+8Kvo1D
	C8NEOI6FLohcQ+cOeAVXmnsZFOeBHHE2SNDd8/kFsbESrZSXQIxl7jo9M2fWdr0TXK6PcT2+vIo
	9R6rI+oSR0F6JtloWG1uR3ZtUwbRMQdR3vHVcaP+lEbFBCeAc67t
X-Received: by 2002:ac8:5a94:0:b0:531:16a:5a3d with SMTP id
 d75a77b69052e-535149262fcmr842331cf.12.1790981147901; Fri, 02 Oct 2026
 15:45:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260929032229.3532247-1-danielmentz@google.com> <CAFgf54p=0wy9vAJKf8U_B9r27Z8UfqoNCXCeMDPdVETK9m5kAQ@mail.gmail.com>
In-Reply-To: <CAFgf54p=0wy9vAJKf8U_B9r27Z8UfqoNCXCeMDPdVETK9m5kAQ@mail.gmail.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Fri, 2 Oct 2026 15:45:36 -0700
X-Gm-Features: AclHuK9C1mykAPGW2LozKJaWwIrPicnc-cAJAcON6rNq9TejSYBgxUBDdZwGJ74
Message-ID: <CAE2F3rACz6Z7X3NNfLWEfjTD9K9YJyYHHyGzcBafEemTFGhgqQ@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Align memory attributes for
 SMMU-originated accesses
To: Mostafa Saleh <smostafa@google.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, dawei.li@linux.dev, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mostafa,

On Thu, Oct 1, 2026 at 2:22=E2=80=AFAM Mostafa Saleh <smostafa@google.com> =
wrote:
> A similar patch was posted previously, and Robin highlighted the
> reasoning for keeping it as is:
> https://lore.kernel.org/linux-iommu/c25309d1-0424-495e-82af-d025b3e6d8c8@=
arm.com/
>
> It'd be great to highlight any changes since then.

Thanks for the pointer. I wasn't previously aware of that email thread.
Having read through the full discussion now, I don't think Dawei Li's
patch was rejected on principle, nor did Robin argue that the driver
should keep programming Write-Back attributes for non-coherent SMMUs:

1. In that message, Robin was explaining why the existing code happened
   to work in practice on common AXI implementations ("the Normal
   Cacheable attribute will inherently degrade to a non-snooping (and
   thus effectively Normal Non-Cacheable) one, as that's essentially
   what AXI will do in practice"), and pushing back against the Fixes: /
   stable tags and against abusing firmware COHACC overrides to operate
   a coherent SMMU non-coherently.

   In his follow-up reply in the same thread [1], Robin clarified:

   "Oh, I'm not saying that we *shouldn't* set our attributes more
   exactly - this would still be needed for doing things the "right"
   way too - I just want to be very clear on the reasons why."

   Will also noted in the same thread [2]:

   "I'm not against being more careful about the memory attributes used
   by the non-coherent walker..."

   Dawei agreed to address the review feedback (such as dropping the
   unnecessary Q_BASE_RWA / STRTAB_BASE_RA changes, since allocation
   hints are ignored when Non-Cacheable is configured per IHI 0070
   section 6.3.11), and simply never sent a v2.

2. More importantly, Robin's observation about AXI degrading Normal
   Cacheable to non-snooping is based on the behavior of common
   implementations, not on the Arm SMMUv3 Architecture Specification
   (ARM IHI 0070).

   Under ARM IHI 0070 section 3.15 ("Coherency considerations and memory
   access types"):

   "ARM expects that this be IO-coherent access to normal shared memory,
   but in implementations that cannot support cache coherency, this
   might be non-cached access. ... The degree to which the different
   memory access types and attributes are supported is IMPLEMENTATION
   DEFINED."

   Furthermore, section 6.3.11 ("SMMU_CR1") and section 13.1.2
   ("Attribute support") explicitly permit an SMMU and memory system to
   reject unsupported memory attributes with an External Abort:

   "Where an SMMU and the memory system support only a subset of memory
   types, and where access to an unsupported type can be reported to the
   SMMU, the SMMU will record an external abort for the cause of the
   access in question in the architected manner."

   Section 13.1.2 specifically lists the resulting faults for
   SMMU-originated accesses using unsupported memory types:
   - STE fetch: F_STE_FETCH
   - CD fetch: F_CD_FETCH
   - Command queue read: GERROR.CMDQ_ERR and CERROR_ABT
   - Event queue access: GERROR.EVENTQ_ABT_ERR
   - PRI queue access: GERROR.PRIQ_ABT_ERR
   - Translation table walk: F_WALK_EABT

   Therefore, a non-coherent SMMUv3 implementation (SMMU_IDR0.COHACC =3D=3D=
 0)
   where every SMMU-originated access configured with Normal Write-Back,
   Inner Shareable attributes fails and records an External Abort is
   completely architecturally compliant, yet unsupported by the current
   arm-smmu-v3 driver.

3. Finally, the Arm Architecture Reference Manual (ARM DDI 0487, section
   B2.8 "Mismatched memory attributes") explicitly warns against
   accessing the same memory location with mismatched attributes across
   agents:

   "There might be a loss of coherency when multiple agents attempt to
   access a memory Location [with mismatched memory attributes]."

   On a non-coherent SMMU, stream tables, CD tables, and queues are
   allocated via dma_alloc_coherent() / dmam_alloc_coherent(), which
   maps them as Normal Non-Cacheable on the CPU. Programming the SMMU to
   access those same buffers as Normal Write-Back, Inner Shareable
   creates mismatched memory attributes between the CPU and the SMMU.

   We already avoid this for Stage 1 and Stage 2 translation table walks
   in io-pgtable-arm by selecting Non-Cacheable, Outer Shareable when
   !coherent_walk. This patch simply brings SMMU_CR1 and
   STE.{S1CIR,S1COR,S1CSH} into compliance with the same rule.

[1] https://lore.kernel.org/linux-iommu/f253d6aa-1dc2-4b1a-85df-f43b06719c0=
4@arm.com/
[2] https://lore.kernel.org/linux-iommu/aW9xs1ko3nWq5VbS@willie-the-truck/

Thanks,
Daniel
