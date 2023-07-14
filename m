Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3A1D51F
	for <iommu@lists.linux.dev>; Fri, 14 Jul 2023 09:13:14 +0000 (UTC)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-403b622101bso209681cf.1
        for <iommu@lists.linux.dev>; Fri, 14 Jul 2023 02:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689325993; x=1691917993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXXFs1U0EQirANF72vGzE97gcx0mGEeOxn7yBPDJD4A=;
        b=B2Qy7FEqZ7cpvpNr/7I7YyMWCRE03jyN3Wx391rY6FsqZwmNbHkQyghsyfh0t/C9Ge
         bNH5jHKznr5cb3VD1TAhKhrL4671zDAJLKeC+OPeWd/F6i+htAtjtQUYfDqbvrdDYLqo
         7vsPeYv+0QwctoFSm6VMY49JcvLwU1JLAgN/b/kA4AJhd1YIpApVBScBnozL5Bo4+WY8
         v1QXeO4C/lsCfryAivvaIQfQY1/ASdrsLClpld1HKvJ5tOWHPoG1IjECl+8aadEHVcKH
         AOgRaI2pdsc3Kqu9KJUpKkO22y5lIvgEgQOrrQmZD6tY5SXDT1qHxQofIVTIO6FPPVux
         T0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689325993; x=1691917993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CXXFs1U0EQirANF72vGzE97gcx0mGEeOxn7yBPDJD4A=;
        b=MlaQmB3F70mVHaIIg13EwC41RHZzyPM+OEz0r7fei4c9ph7q18jpbqjTLIuHDyedko
         HZaxx9y0++/5oMUDOF1riL24TVMaGV9bdNUNot6/CzJ5lFSdBbE5x1Tc6IyD4UCC8A3i
         KUPySRye52es7Qx2vbV73R4+6uDjyqitBZkgLUfuWo1eNSRlcYhrgCvdLFI5csKQC102
         ugYbcmG3RZvrroYol2SAg9a6dKVRGqf8p9aCKO038gp27fXbV7j5GGy8q2MY6WWMIzTU
         OYKj31O3of2pq9Z13i9cHmLLKhPfVY6L80zw5UdPxbdB8EbsUAPBo3YiLdgYN430qyBS
         A/eg==
X-Gm-Message-State: ABy/qLbsn0eLKxssHpuPjUo7Sq/hf5Byv+DBBa8FYnGccsKUrypjkiPb
	+auAUnSNZ2AHz81npzPx/Ty4tcGUw4Peyn7bvaa2pg==
X-Google-Smtp-Source: APBJJlHMkDrXr7BvzQxv+DKt/d+UTDl7PF7376N1v7BM/R1n9czmCwE+wgwvAnTdTWWotOkhYFRfKkgvySA+/jhFiks=
X-Received: by 2002:ac8:7f8a:0:b0:403:aee3:64f7 with SMTP id
 z10-20020ac87f8a000000b00403aee364f7mr794692qtj.6.1689325993037; Fri, 14 Jul
 2023 02:13:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230621063825.268890-1-mshavit@google.com> <20230621063825.268890-3-mshavit@google.com>
 <ZK9RycgNAVrxe343@Asurada-Nvidia> <CAKHBV26wi+xKnNjo-R+QOcVLPH2KJTFP+mF4CW1xE61nOdF5GA@mail.gmail.com>
 <ZLAKQw+DzcpSRSyi@nvidia.com> <CAKHBV25YadRVFiag5z5Yc13L093ScWkCjAOCd=VuGm2RUaDyzA@mail.gmail.com>
 <ZLApQjaqoOshT2TJ@nvidia.com> <ZLBWh370pPjx2B+z@Asurada-Nvidia>
 <ZLCNUNRsWy/YuHhQ@nvidia.com> <ZLChc4A58PkU2Fe5@Asurada-Nvidia>
In-Reply-To: <ZLChc4A58PkU2Fe5@Asurada-Nvidia>
From: Michael Shavit <mshavit@google.com>
Date: Fri, 14 Jul 2023 17:12:35 +0800
Message-ID: <CAKHBV240_0bUE-25sND3oSG57jT0yJiZzAt+fPTXehjm=zmRBw@mail.gmail.com>
Subject: Re: [PATCH v4 02/13] iommu/arm-smmu-v3: Add smmu_s1_cfg to smmu_master
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 14, 2023 at 9:14=E2=80=AFAM Nicolin Chen <nicolinc@nvidia.com> =
wrote:
> @Michael,
> Would it be possible for you to update a v5, following Jason's
> suggestion overall? And I think we can have a smaller refactor
> series first without set_dev_pasid, to have a common codeline
> sooner for us to add new features, such as set_dev_pasid, the
> use case of IDENTITY default substream, and the nesting series.
> I will help testing with some pasid/non-pasid use cases too.

Want to make sure I fully understand these last few messages first. At
a high level, we want:
1. arm_smmu_master is allowed to own a CD table, but not an
STE-precursor (s1_cfg/s2_cfg). The s1_cfg is practically already that,
and we can probably get there with minimal changes.
2. arm_smmu_master shouldn't point to the currently active CD table
(which may or may not be the one it owns) or STE-precursor as a
shortcut. All code should figure it out by looking at the master's
currently attached domain (functionality could be provided by helper).
3. arm_smmu_domain shouldn't pre-generate any STE-precursors. The
STE/CD for a domain should either be computed right when it is
written, or computed ahead of time and stored as a copy in the
smmu-domain.
Is that right?
