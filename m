Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6922D8478
	for <iommu@lists.linux.dev>; Fri, 18 Aug 2023 03:45:32 +0000 (UTC)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-407db3e9669so109621cf.1
        for <iommu@lists.linux.dev>; Thu, 17 Aug 2023 20:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692330331; x=1692935131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vH4LP9L3QrJT8d+/R2AdJ28zLhHHmQV+XH1lBPN3qj4=;
        b=VVklt4MBTiZJmwuT732hKQfOnMpKb5FP5g3NY2XwyNITm28HJT/ojjxSqQAKZgYKDJ
         WmK6sy/T+2/J7foKATsAuvm6TQ6Ao3CAZRNbAkovxxn6GLkdatFn7JUran80V2bB8Pbj
         YYyKeQ3ZCehFggvSZgiip0VacxYxJkGI7NRzIffbmjH1AQ9I59PoUw+HtsMbJ22NVUtK
         5HGbWn8cJIzYPQSNw1rgsKFLA+0FllhM8X8UoJBXXMA8EZXskI/BRNmk8Ngi0FSuX7sL
         rnqaD6Mhzx3SRdE9rV4LJlEaUjfzzyPkmPMIzVKFuZwcXyc77Id3P/hteYlVcM/v4NRp
         pDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692330331; x=1692935131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vH4LP9L3QrJT8d+/R2AdJ28zLhHHmQV+XH1lBPN3qj4=;
        b=SdcSVfnxDWko7iwbtMkccFa690k7rzPvmUnN1P3Wu3RXJTpINGOUaYH/q8dAXzdd1y
         ZMg3KRAIP1e2O5KvxHHYvy7jBcbeih8/4CoKR0c9gJmPZ9nbh8XiPc9mkd6WUrWrMFgj
         w/u3MhhebxYCfvub7i0+TaPdr/LnuYTPSjdMPXPXo/jbYT75uTSlEdjxjhRpy7Jb3pp0
         oxbMAPGT57iKxLArIP4/D45Ue/olNKLWVdhS3F0OZOBWZ78dUj3xP4fk185uCeQ9ZHYW
         36p7sgiymkW2yXQo6Qs5/P32s/wT66R3vx92GVjHgiPE+9xJhSGMw+o2vUAhhKI8C3nr
         Ieqw==
X-Gm-Message-State: AOJu0Yz0JAfPTbhUvy3RGbkszMU30xAyMJFTaY5zXkA8422EFyPjKcJc
	Lk4oXLqFbYdMHzbS33poHw3S2DAPpzVMnLwxWDw9UA==
X-Google-Smtp-Source: AGHT+IG/BMhxtfee9/cPpC2ZS18i+DFAlUZhyeGLDN74YZh7dgXIhsHPN7BhDqccdIT0wEHPat+IQEQUgA28CM2ZhkQ=
X-Received: by 2002:a05:622a:1316:b0:403:aa88:cf7e with SMTP id
 v22-20020a05622a131600b00403aa88cf7emr89675qtk.29.1692330331033; Thu, 17 Aug
 2023 20:45:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230817182055.1770180-1-mshavit@google.com> <20230818021629.RFC.v1.2.I782000a264a60e00ecad1bee06fd1413685f9253@changeid>
 <ZN5y4N8ffSoiR/sm@nvidia.com> <05f69a1a-97c9-ebca-5e01-c0b00699c93e@arm.com>
In-Reply-To: <05f69a1a-97c9-ebca-5e01-c0b00699c93e@arm.com>
From: Michael Shavit <mshavit@google.com>
Date: Fri, 18 Aug 2023 11:44:55 +0800
Message-ID: <CAKHBV27suc5nDoH7gMHebjYBONTNqsugWvxbo2E-fRjRGs288w@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/8] iommu/arm-smmu-v3: Perform invalidations over installed_smmus
To: Robin Murphy <robin.murphy@arm.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	will@kernel.org, nicolinc@nvidia.com, tina.zhang@intel.com, 
	jean-philippe@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 18, 2023 at 3:41=E2=80=AFAM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 2023-08-17 20:20, Jason Gunthorpe wrote:
> > It is certainly wrong to skip invalidations generated for any other
> > reason.
> >
> >  From what I can tell SVA domains should have their CD table entry
> > programmed with "ASET=3D0" and normal paging domains should be
> > programmed with "ASET=3D1". This causes only the SVA domains to listen
> > to the BTM invalidations.
>
> Correct.
>
> Thanks,
> Robin.

Would it be fair to rename arm_smmu_tlb_inv_asid (or move into
arm-smmu-v3-sva) to make it explicit that it shouldn't be used outside
of SVA then? Or add a parameter such as skip_btm_capable_devices.
