Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A0E17752
	for <iommu@lists.linux.dev>; Wed,  9 Aug 2023 14:57:51 +0000 (UTC)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-40398ccdaeeso35574301cf.3
        for <iommu@lists.linux.dev>; Wed, 09 Aug 2023 07:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691593070; x=1692197870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HpMhr6QD+95gO3zovNgjrpdIT5cUPg1o1tOLgZJnwGY=;
        b=hLXQVlNLelozyJU+bMnYuq1dfWyKA32ocR+Yqn1lylxJDEsL6wr0oakubcd0IMsOhS
         NVqoyF2vVCIqlBuVQrG5aJE7INO9gJqQzauN7dyqUmmVUcqx9L+3sgjIjFX2QO2ClYJy
         rvFmhdqeL9nEFIvBLrUZ3m3uEBjmQRBpk9XK/ms2KoLHID/+dtoBpdjBErcu/OLHrQF1
         HyXFnoMmG2QhzyiCj0Z4W99t1UYCtTkmO79eup9BPRlQ0s+SFxkHR9C9+/n9yTI5x4Rz
         dtMyCPqw9hxolBatOIPRnHBRQHeBxUpZC/rydY1bBkD4SD8ZCtZv8QeM/QOAd6D+yhC0
         YY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691593070; x=1692197870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HpMhr6QD+95gO3zovNgjrpdIT5cUPg1o1tOLgZJnwGY=;
        b=cvptVbs9Z2BRXy2u+o/AP3KAOQaDUDS1x7Phng73/rgLzblLOE0aemND/YGHe1S2eR
         Cm60lodBpjuhJYMiT5hzDZZBdsAJuk2XuNdFszO/TRF+u3bV/yVr9zKcU7ZA2MQlv+d5
         UXD3VamgLiXx3KK095VRRy048gKJc03aeRJk6e2r6qtFkXy+Mc8KX3Tk9QDUtlsxQbnt
         laSnoYOtv4Wwxqg0FQpBFBdporhXZRq6uViHiZDzKu6KxoGczMGedpEpI4Ifi0wdeOII
         cEC/yeCLYOoLS5D5e8uu545UzkqMc7Wj1Wh+erRunuDZFxVJ6P/onm4dfO/rtzWxxpbH
         afBA==
X-Gm-Message-State: AOJu0Yy3YDw6L6U/j2uRRZTcxypH6FlYqZ4EqI6S3nMongHKIl3Z78Mz
	T3isA9k5tqB4MgWqiAR8p45qJw==
X-Google-Smtp-Source: AGHT+IF/Eb2IIrd1xEjQy4quw86/nLSkYTOnDYFOrxCFoJ5y6Vyhcm86eTM1GOzIdk8SC98VBkH6Aw==
X-Received: by 2002:ac8:4e47:0:b0:405:3dcf:1182 with SMTP id e7-20020ac84e47000000b004053dcf1182mr3857027qtw.50.1691593070645;
        Wed, 09 Aug 2023 07:57:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id w12-20020a05620a148c00b007671b599cf5sm4017361qkj.40.2023.08.09.07.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 07:57:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qTkdB-0053kn-JN;
	Wed, 09 Aug 2023 11:57:49 -0300
Date: Wed, 9 Aug 2023 11:57:49 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zong Li <zong.li@sifive.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com,
	linux-kernel@vger.kernel.org, Sebastien Boeuf <seb@rivosinc.com>,
	iommu@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 03/11] dt-bindings: Add RISC-V IOMMU bindings
Message-ID: <ZNOpbac4i5zfmHj4@ziepe.ca>
References: <d62ceb33620cab766d809e6bbf30eaf5b46bc955.1689792825.git.tjeznach@rivosinc.com>
 <CANXhq0r=2eqpy9wLjVt1U0J7=LpnJLcKV7N9d90jvCss=7+Fzg@mail.gmail.com>
 <CAK9=C2Vg9eR5LJPeqDDQ0pHZcrT5DOUzA8_wYEVEjfnhb6s8pw@mail.gmail.com>
 <CANXhq0oTrU_-OQroW7H+hvxcU7YROhkgdCF9g_WtPTzVFQL7gA@mail.gmail.com>
 <CAK9=C2XoQjPzZ5yB5jfTbee4-Pb8GgFAZRbfcMwMk9pyo39WxQ@mail.gmail.com>
 <CANXhq0q7R9Srx6U=fReq7LDLFgW6rMmjKH=o6MzDT5AWNRXP6w@mail.gmail.com>
 <592edb17-7fa4-3b5b-2803-e8c50c322eee@linux.intel.com>
 <CANXhq0pS_=YxgrxSKbdfrFdGcBduzk3LTyC4vp_hqoJTbX3e0g@mail.gmail.com>
 <ZMEO1kNGfGjN6kZM@ziepe.ca>
 <CANXhq0qMWS_j0n_aUO8BVFSedYCjuMM=Z_tsnK05ZhG+Ob6pqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANXhq0qMWS_j0n_aUO8BVFSedYCjuMM=Z_tsnK05ZhG+Ob6pqw@mail.gmail.com>

On Thu, Jul 27, 2023 at 10:42:47AM +0800, Zong Li wrote:

> Perhaps this question could be related to the scenarios in which
> devices wish to be in bypass mode when the IOMMU is in translation
> mode, and why IOMMU defines/supports this case. Currently, I could
> envision a scenario where a device is already connected to the IOMMU
> in hardware, but it is not functioning correctly, or there are
> performance impacts. If modifying the hardware is not feasible, a
> default configuration that allows bypass mode could be provided as a
> solution. There might be other scenarios that I might have overlooked.
> It seems to me since IOMMU supports this configuration, it would be
> advantageous to have an approach to achieve it, and DT might be a
> flexible way.

So far we've taken the approach that broken hardware is quirked in the
kernel by matching OF compatible string pattners. This is HW that is
completely broken and the IOMMU doesn't work at all for it.

HW that is slow or whatever is not quirked and this is an admin policy
choice where the system should land on the security/performance
spectrum.

So I'm not sure adding DT makes sense here.

Jason
