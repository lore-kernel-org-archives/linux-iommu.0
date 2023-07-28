Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D036C2C0
	for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 07:35:18 +0000 (UTC)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-40631c5b9e9so164271cf.1
        for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 00:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690529717; x=1691134517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDPcwp2Mz7C9Ps/iDhtZ7bunn4aijZQT9NN7+iAapjE=;
        b=enyIBgwAzyuWA4J7wtv2SOUubtS9qNle3EYaLS2TgsFOC+e4n9N2BIKHbKeYDdtyXE
         k+6wMKY0IpytJSvZ9oxRr44s9qeFc4Vp/PvLsf6kOsdm4a7IIUsf2dxpMRmmu7ZcXDTI
         0STmNj0oz/hR40nn4tgPCz7QnS+5YkpciOlONChR2XSLwpvEe8sWc1/oatPzoI7aO91q
         zG7X8RuQpP2JX3HXDMbuNDuAe/UFPNI0RxYArQQ+jaoK7AjLDe13czEvAYuQjDXRnRMo
         gUc9K8sjiDTqFk34TNN5QQGwiflosPTBtsLaDYz1I7ukkZlTTQm0nWI78Ga5khz6/Q6B
         7h3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690529717; x=1691134517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDPcwp2Mz7C9Ps/iDhtZ7bunn4aijZQT9NN7+iAapjE=;
        b=Mh96WTqurTuQR+zLLDgn5NITvx5KZS/EP8gAsHcY7B+hlCDhOqnZGRGwKah7J958l8
         HiBkZThAfj6ATO7t31aIurkuHqgJNwSZcFGLEkzh2i3HqA4I/yUmegxFi8GJeUUfcio3
         4FK4K6cO1W1bHryqpBEGu3JmbjQ4/CUwLJNBh5fLfTk4YDkfASATgIDJuFTtq5vexmOW
         XWI870aRUmmoYbTVBU5xjwYOaNXyCvcEPh7DYknDsoTAw7S6OpY2q03Yua5Q5AQvzo1Q
         1cUCMaB4aoK8BeUyz4EQ0WzzfhjpY6nRpFkRWgpqdZFgg7sGNMw4fFtAc2Vky8w4qtBD
         qUTg==
X-Gm-Message-State: ABy/qLZQ9slna21i71L9zaG6394Vxvkk6tqsPvKHY8SMfi79hLtU2+0A
	gGFKlPSzD/fgUYpE9WTyMBGVt5UYalWZnlRq3orUK4FydOQzJrJ4JiM=
X-Google-Smtp-Source: APBJJlE/pbAViIj8z7R0ccyCBgMKazmGFjRMSrrXL0qn1D946pmZzAb/dW3nng2iPFM+zl342ybtqyqB9ublMYbARVE=
X-Received: by 2002:ac8:5907:0:b0:3f8:5b2:aef5 with SMTP id
 7-20020ac85907000000b003f805b2aef5mr158028qty.29.1690529716970; Fri, 28 Jul
 2023 00:35:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230727182647.4106140-1-mshavit@google.com> <20230727182647.4106140-7-mshavit@google.com>
 <ZMLjqfp6M6n7HAxl@Asurada-Nvidia>
In-Reply-To: <ZMLjqfp6M6n7HAxl@Asurada-Nvidia>
From: Michael Shavit <mshavit@google.com>
Date: Fri, 28 Jul 2023 15:34:40 +0800
Message-ID: <CAKHBV24bEYboxv9XXPvgt86q2B2DTm2He-mbO=kJqsNijCmMMg@mail.gmail.com>
Subject: Re: [PATCH v1 6/7] iommu/arm-smmu-v3: Refactor write_ctx_desc
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org, jgg@nvidia.com, 
	baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2023 at 5:38=E2=80=AFAM Nicolin Chen <nicolinc@nvidia.com> =
wrote:
> > @@ -1101,11 +1094,11 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_dom=
ain *smmu_domain, int ssid,
> >                 cdptr[3] =3D cpu_to_le64(cd->mair);
> >
> >                 /*
> > -                * STE is live, and the SMMU might read dwords of this =
CD in any
> > -                * order. Ensure that it observes valid values before r=
eading
> > -                * V=3D1.
> > +                * STE may be live, and the SMMU might read dwords of t=
his CD
> > +                * in any order. Ensure that it observes valid values b=
efore
> > +                * reading V=3D1.
>
> This seems to be true only after the following patch? If so, we
> should move this part over there too.

This comment is more in theme with the next commit so I can move it
over. But FWIW, the fact that the STE is not necessarily live at this
location is true before this patch, in this patch, and after the
following patch. Fixing this comment is just a drive-by, not a result
of any of these changes.
