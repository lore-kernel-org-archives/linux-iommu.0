Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D60131ED7C
	for <iommu@lists.linux.dev>; Tue,  7 Jul 2026 23:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783465488; cv=pass; b=izxl/7dNXpAMUHf1L2vRcnGReDxUAP9kXGgCxQqkuof73xCrS293aRNl1JzoWi4t7eWF/90O91v7SfMbfoneD4FAkPTbFNDH/yH9KE2eEjsSAkDdD3z84AhwQ+ijaZB+ArWl42ZuSXwsgViUbpxFkXvF4OOPDv5Iqh82yrCjUcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783465488; c=relaxed/simple;
	bh=UJCG15RqjZM9VwC2ZMUtoDMeZ/DnczqolCzMGW46D+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FuceukNOWWM1ahZlD3ZDMkvdgwvPvyUE3lGIvUhEvAfZH2T6sJByuXyyyI3gB1f30FumuXS9bH5RNmb7Ev78FRNMkZ0xVB1S9x+nj/ipcFOrlf7ntRGOxR4BJ3tgzbDYy1RJTLqG4Jyd1gFnGzB/eWU/MvehlQhyeQO2t//Vjtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GH6zJJOf; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GH6zJJOf"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c15a5b265so109761cf.0
        for <iommu@lists.linux.dev>; Tue, 07 Jul 2026 16:04:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783465486; cv=none;
        d=google.com; s=arc-20260327;
        b=cIijzzj29ckFmUqopdOJk9wNjSf0SJ7m2fq0TV/1KGYg3ml1YM+/4b/w0M1E/B6vMB
         Pet9dOGSLVQ9dV4pR7+B+nRY12ucjGCkedh6plsNYu0rrsgFoDARZUOaT/i4byuNoEuG
         dmbEG9vtj9zfCEuimswNiILvUedsd0cePvT5szugkV7owjGzBeB4PPHiZtQjMRlMWoCk
         lBsp5At5YacklbGiEwujgWhT54J//v/MVDnUez6i60JdKrR/yrURPP2Ns4h3LwM2YIK4
         o0GIfo/so83tYOWUKS8rcJlJnQ5wHu754v+2EzT0dGjSkRA3Ux9MF1EOUiropAwVtjXP
         CMGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UJCG15RqjZM9VwC2ZMUtoDMeZ/DnczqolCzMGW46D+g=;
        fh=cAGQsmWcJDuWpazWYeiONMmxjv7xKc3zCBfuq5oL8OU=;
        b=Dq9vzSqUciJT7tx7ShJuaysZ9HS+WVHhO8Ogx8mrXTJ8c4z9UkTmFA1sKWBoDNR7nq
         erVtQY1Z5oQu8Ru8rb1SlIywbcHy0/Im8ud4pQrDGbeYO0OkO1lzvpWRuqquDrSVBJvG
         61l19pLNTmoYjI1cLJW9NhdQZ46PWpeh+TzngzO2l/b782utDWwDi0TsEXYroIjppAfl
         u6QabJHgSlbxUWazCBU0MDv2oRDRvuAzKmGEcmz05kL4q8XlaeTDbi+tW6detheEjZTW
         N5/AkdOFChAw4DoEOOuFd0+TQlHHQ4wL0j71uWwSaxY6B7opYMfcEZoABVSmdh77xXvI
         gjqQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783465486; x=1784070286; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UJCG15RqjZM9VwC2ZMUtoDMeZ/DnczqolCzMGW46D+g=;
        b=GH6zJJOfwFDnU4F8EEAZDJRPz/bFUqyEur7h1CSWq5B/+rQjgeHiaL84DjejHw1BGd
         eeyHDWIuMeOUKaL70lw6nsr10WGSeoA9QC1pqib3ZloOsQTd4Zc4w9aAZRUZ7AWmlH2T
         r2Od+HeSew1ny7QdkAnMvASBIdBbZRsNiJZuGH0e+aOb0f/H6iatVCNUy7d9IzwbNz1S
         o+Odvq5ifdb/wNeD1CSE0Gc6va3uteWg6ZgGuSCCJ2qBtc6j20MEBJh/xgt0TpB00NrD
         7WTVZ7m/Bi/0x+Y0KvonX5HKNr3oCBYBwAkjyw0V5b4eil7TlHmYBa9jitU5rC4xGO5z
         I+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783465486; x=1784070286;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UJCG15RqjZM9VwC2ZMUtoDMeZ/DnczqolCzMGW46D+g=;
        b=ZDGfbJkF+m6Opb1QwBSAiEJ9SdHtTfz5lLACMpkryRak2t7X5LUpWktsc5qQFGkdNk
         WO1Hy6Si0L++aX/LVuq/OeG/UFkRFr8l3MeDua8t05Z5R8kTJotF6Fdqq8hehMFodrLp
         /WsH3AWYMtBxdwx7mRNsKVQ6ZMW8TcTpcUcLywZOt2rqHaEPVjO4fwOCfHcUxIf3Irvk
         dwkXIAlK8sQU3SasKdSTIa5qhToVcHSPdNtbnSVvAXJlLS3+5e4omnJJqQtlFJKdXefp
         rVWzlwBObIxnjr66s8IUJXQ3l8UwEg63dD0WqbCuOfmuCWyaqdTcY+w17z/hR+eONzud
         INQA==
X-Forwarded-Encrypted: i=1; AHgh+Ro5VpeVj7Z3vNFytyl6JFEB9FXE+uFSozwBJfCRIOdgq3zz9EcQBFhPY66dF+wGlS6Nx1okOg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzCSORal69SCJSChpe/xcUvvGf0zzYZL5rMn0p+0bPzxiA7XQkp
	5TGiiNj6UT6DLLPN+ctqzx2mQYv+RzUs5pa2d6aWy9cgSCyQX1T+iMeCxbh/icjQKTPziMjS2Oa
	coKbrTCpVHrGUP5QCJA1CjIQO0iBREQVHDx73ee5s
X-Gm-Gg: AfdE7cmPrUO3rO8pNtcy0M6Njbe1beUOY17GUvr1tcDyTs4OvAXVizh2IyGxyfS7mF+
	bY7RUmruQ7mPfSB1rpxcDfUCtQVHDB/r2NFwILYWkD6LW7yGtV8cVuSQDUdOjcpOwLM2HAizKY6
	JXZ3x9tLx4IPXqHgdfVL/Z/15wQsUkOLRCX7xft8E9QUQNgrqNuHWQ80+AXAtO1e35JZBhQ3Dun
	KNHvzL2UWE2jSEOI261U1B9QnX6hTW19sm0JhJ4axPIJTj5IHJkIrULkHQszJFlTcRl8H/yM9iO
	UWIV59YGNeOQW/D1k53G40vV7OrB8HgsbPkz
X-Received: by 2002:ac8:5f4c:0:b0:51b:fd5e:e81a with SMTP id
 d75a77b69052e-51c7b43344amr11256661cf.20.1783465483775; Tue, 07 Jul 2026
 16:04:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260618-iommu_contig_hint-v1-1-4502a59e6388@oss.qualcomm.com> <20260703161228.GA1948451@nvidia.com>
In-Reply-To: <20260703161228.GA1948451@nvidia.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Tue, 7 Jul 2026 16:04:31 -0700
X-Gm-Features: AVVi8CfuI8cp_vTcATMKW7PcdPdPcCuC2smvbVMutN55JZh4YqKCDGaKUlDmCMs
Message-ID: <CAE2F3rDR3PaiHo8KW26jTqWYD0EfG2mqbfEHhupEzHYENxz=Vg@mail.gmail.com>
Subject: Re: [PATCH] iommu/io-pgtable-arm: Add support for contiguous hint bit
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Prakash Gupta <prakash.gupta@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 3, 2026 at 9:18=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> On Thu, Jun 18, 2026 at 02:32:09PM +0530, Vijayanand Jitta wrote:
> > From: Prakash Gupta <prakash.gupta@oss.qualcomm.com>
> > Add support for the contiguous hint (CONT) bit in ARM LPAE page tables.

[...]

> > Support is gated behind CONFIG_IOMMU_IO_PGTABLE_CONTIG_HINT, which
> > provides a compile-time opt-out for hardware affected by SMMU errata
> > related to the contiguous bit.
>
> I reviewed the errata and didn't find any related to contig that
> required disabling contig, the driver was OK with the ones I
> found.. Did you find something specific?

Arm MMU-700 is affected by erratum 3777127 ("Under invalidation in TBU
possible when using contiguous page table entries"). However, if we
disallow partial unmaps of groups of adjacent translation table
entries, we implicitly apply the workaround ("Ensure that contiguous
page tables are removed using a single range invalidation. Arm
recommends using range invalidations to remove contiguous entries
anyway for performance reasons.")
