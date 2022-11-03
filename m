Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2FD7488
	for <iommu@lists.linux.dev>; Thu,  3 Nov 2022 14:55:46 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so5416143pjc.3
        for <iommu@lists.linux.dev>; Thu, 03 Nov 2022 07:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t/NrioDw2KFq6mJ3bVbRI+ixY4f+9g6gFasJn7MZM6M=;
        b=rJkZmYWpfntVKVk7RpeWnoFkGl5MYV9fqkQy+uhqSUZd8I5rQ9KEWF727GdBwyv3sk
         Kgd8e3AX1tMsFIKugXIghb1NH07wTnvI/HIKMzZp0H5a0ElIZvT57CZWWxM8oYQCTzxl
         tSVJ4uulQExyKTjJMY7Ch4mHvoDVilhLCKN/+eDjJo+ctTykGIrmowWIUCebVGeYUlP7
         4qfNXDjfBN4AUK7ExEjXXSKGb9VyabyfwXsRpywXBpkT50Qiq4tUgSCkZQTT2eDYkPIK
         xnynjuCDwE9FvQVKz8ZyGxaNAXZoAxOyvNS3pTdPtufKE0aUR/lFQmpC005iuIUkADAs
         /Z7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t/NrioDw2KFq6mJ3bVbRI+ixY4f+9g6gFasJn7MZM6M=;
        b=YXz9arYJAGnMFV+3KQqCo8KwRNkfy2JmPj/tiGgtOFD5mFpc1r5AaLSqJYybVWa5vR
         GkvPXaRXn1F57HKjzfxrSr4Fz2Erop8kPWouSE+Yzosf4BNMbGxh16/GCwupq8Q3RhBK
         iv0hoOccWkR8IOD/oIVWvPPnn3lVN0oHsDXZQBax2mDjvz/fNEE5bG8A5luzVSz6tvRZ
         hCxMBZU7NGxhyA8AN8bxvFT9rSToauatT1SmunLAMZbd/9ljo4u+QPbViPRgj/uK+iSA
         1QgK97hJueKu3jQTkGsQRasUY87HRXMUE+bdlsVIGJpv5q0h2oyLgb4E5JDsqBfjQQ4d
         qA8A==
X-Gm-Message-State: ACrzQf2g7NgJenCOkgB7ZdSfb1Ohtk83kyrcQVYaADSPZXMxQckgUxqW
	svSWete5wKmmrIaNhL7HyrhMGiUOig2WQm63gT8ZSA==
X-Google-Smtp-Source: AMsMyM4MUJeInSpCoBN6Nw7WgpaIGWe+Q/h4WSomAyuSBcWfpyVw2c5LyrS7bLPmw/14e0Rhj1R+GF4rkXdJxIeX0xI=
X-Received: by 2002:a17:90b:1d90:b0:213:c798:86f6 with SMTP id
 pf16-20020a17090b1d9000b00213c79886f6mr26575996pjb.84.1667487346285; Thu, 03
 Nov 2022 07:55:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAPDyKFqJdiCDkAfrONfnBVKw1v8=jZ+hEJiKGK70EQ4o7BSxaQ@mail.gmail.com>
 <20221103043852.24718-1-pshete@nvidia.com> <6be39bae-f325-12e0-374b-a27c9ee2ef2b@arm.com>
 <Y2PJq27wkVwPg6rp@orome>
In-Reply-To: <Y2PJq27wkVwPg6rp@orome>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 3 Nov 2022 15:55:09 +0100
Message-ID: <CAPDyKFq8szzryFBNkw20wFoPTbAa8YDy0wJnb57yckZ-HFTAMw@mail.gmail.com>
Subject: Re: [PATCH v10 1/4] iommu: Always define struct iommu_fwspec
To: Robin Murphy <robin.murphy@arm.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Prathamesh Shete <pshete@nvidia.com>, joro@8bytes.org, adrian.hunter@intel.com, 
	jonathanh@nvidia.com, p.zabel@pengutronix.de, linux-mmc@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, will@kernel.org, 
	iommu@lists.linux.dev, anrao@nvidia.com, smangipudi@nvidia.com, 
	kyarlagadda@nvidia.com, Thierry Reding <treding@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Nov 2022 at 15:01, Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Thu, Nov 03, 2022 at 12:23:20PM +0000, Robin Murphy wrote:
> > On 2022-11-03 04:38, Prathamesh Shete wrote:
> > > In order to fully make use of the !IOMMU_API stub functions, make the
> > > struct iommu_fwspec always available so that users of the stubs can keep
> > > using the structure's internals without causing compile failures.
> >
> > I'm really in two minds about this... fwspecs are an internal detail of the
> > IOMMU API that are meant to be private between individual drivers and
> > firmware code, so anything poking at them arguably does and should depend on
> > CONFIG_IOMMU_API. It looks like the stub for dev_iommu_fwspec_get() was only
> > added for the sake of one driver that was misusing it where it really wanted
> > device_iommu_mapped(), and has since been fixed, so if anything my
> > preference would be to remove that stub :/
>
> Tegra has been using this type of weak dependency on IOMMU_API mainly in
> order to allow building without the IOMMU support on some old platforms
> where people may actually care about the kernel size (Tegra20 systems
> were sometimes severely constrained and don't have anything that we'd
> call an IOMMU today).
>
> We have similar stubs in place for most other major subsystems in order
> to allow code to simply compile out if the subsystem is disabled, which
> is quite convenient for sharing code between platforms that may want a
> given feature and other platforms that may not want it, without causing
> too much of a hassle with compile-testing.

I agree with the above.

Moreover, the stubs make the code more portable/scalable and so it
becomes easier to maintain.

>
> > I don't technically have much objection to this patch in isolation, but what
> > I don't like is the direction of travel it implies. I see the anti-pattern
> > is only spread across Tegra drivers, making Tegra-specific assumptions, so
> > in my view the best answer would be to abstract that fwpsec dependency into
> > a single Tegra-specific helper, which would better represent the nature of
> > what's really going on here.
>
> I don't see how this is an anti-pattern. It might not be common for
> drivers to need to reach into iommu_fwspec, so that might indeed be
> specific to Tegra (for whatever reason our IP seems to want extra
> flexibility), but the general pattern of using stubs is wide-spread,
> so I don't see why IOMMU_API would need to be special.

Again, I agree.

Moreover, a "git grep CONFIG_IOMMU_API" indicates that the problem
isn't specific to Tegra. The "#ifdef CONFIG_IOMMU_API" seems to be
sprinkled across the kernel. I think it would be nice if we could
improve the situation. So far, using stubs along with what the
$subject patch proposes, seems to me to be the best approach.

[...]

Kind regards
Uffe
