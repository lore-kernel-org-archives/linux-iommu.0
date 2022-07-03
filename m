Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955891FA0
	for <iommu@lists.linux.dev>; Sun,  3 Jul 2022 15:05:36 +0000 (UTC)
Received: by mail-yb1-f179.google.com with SMTP id o2so7319461yba.7
        for <iommu@lists.linux.dev>; Sun, 03 Jul 2022 08:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4QgHhJo99e7BP4qELBN4r2lriKbWdLtk6/DKUxmzOGg=;
        b=Vh7pwmFrp/ki5XJ76jyI5hNuUV1PKQWxt+H19V/GLJ3etny3Ed4qf9e0QV9OMyCnks
         +V7tZtdw1VniQ6BdZSdBWajNOZDP/9WVdUA9+J37kLhzlbC4xMvQ7twWstXyRhygrgEk
         OySwdBIMfbZujBrURcg8GdeODfqyyz4SIitS0W7F6ysxNT0VLPBddMx3/a/GvGvQdxvo
         iMowCy/4ZchQtcTLw19pWaXjlYPd52toUo7sie8xXqMfjy5oNYUEW0ViDYOw6PUrk0C5
         G34+Zs4D16S3OjNGlDvG+54xupVbs4o/Tt1NVLksn8dVuCTj0pxBkrj4yh/fdGcgDAoR
         8k/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4QgHhJo99e7BP4qELBN4r2lriKbWdLtk6/DKUxmzOGg=;
        b=1Di+AwVPGpp91iqKSaSgdt61HkF0o9A/bIvwr6FuTWP6IF9MpYNUnqZLCX8j30x0Hp
         nYFaNwIX/A7NbF0BcqyjXLqwbMTKv+u0Zesncb8U3cMa2WyGnYgVgoqsgkQAP9uf5B4H
         eNDY4rCePMq0KYRWzLf0UFZ3qnGK/hmOG/0jA2srVEyOeyYiFiKiC7jEUEhHP5H6gstE
         pNHSJWLjRQBM2oaRts6TccoovI0BhjNi6R3HScSCQ4MaHW6fvoqXN+LqF5VgJHHgmWLl
         blXgRqiwbh0sE+UPOrEBeKKOR5LiBtEKi5wIjWztouw9BkMLHNissrO4afdqs2MH0YxT
         9V0Q==
X-Gm-Message-State: AJIora+T5ToH49FhNGMe68C2bjzxbiizaOmRKIwM+7xsYePDWMHq6JfL
	UNojXLT07hzaIUnJhvxExt/3tNcG1lNWSJdtoM4=
X-Google-Smtp-Source: AGRyM1uAuVW9IWphg5kSjbYsSYjb/TM871XbOL+Xts9oBKQbm/sejVIg7QWw6bS/e6Nkvrm3x1W/9pxqPUjTrwcE74M=
X-Received: by 2002:a25:858e:0:b0:66e:4898:63e2 with SMTP id
 x14-20020a25858e000000b0066e489863e2mr673140ybk.296.1656860735358; Sun, 03
 Jul 2022 08:05:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220701200056.46555-1-samuel@sholland.org> <20220701200056.46555-8-samuel@sholland.org>
In-Reply-To: <20220701200056.46555-8-samuel@sholland.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 3 Jul 2022 17:04:58 +0200
Message-ID: <CAHp75VccKxO+Gtw46GvxSiPo4ShfpaZPOBehAp6gCoq3gT_9Cw@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] genirq: Return a const cpumask from irq_data_get_affinity_mask
To: Samuel Holland <samuel@sholland.org>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Helgaas <bhelgaas@google.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Borislav Petkov <bp@alien8.de>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Chris Zankel <chris@zankel.net>, 
	Colin Ian King <colin.king@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Dexuan Cui <decui@microsoft.com>, Florian Fainelli <f.fainelli@gmail.com>, Guo Ren <guoren@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Haiyang Zhang <haiyangz@microsoft.com>, Helge Deller <deller@gmx.de>, 
	Ingo Molnar <mingo@redhat.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Jan Beulich <jbeulich@suse.com>, 
	Joerg Roedel <joro@8bytes.org>, Juergen Gross <jgross@suse.com>, Julia Lawall <Julia.Lawall@inria.fr>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Kees Cook <keescook@chromium.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Matt Turner <mattst88@gmail.com>, 
	Max Filippov <jcmvbkbc@gmail.com>, Maximilian Heyne <mheyne@amazon.de>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Rich Felker <dalias@libc.org>, 
	Richard Henderson <rth@twiddle.net>, Rikard Falkeborn <rikard.falkeborn@gmail.com>, 
	Rob Herring <robh@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Serge Semin <fancer.lancer@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Stephen Hemminger <sthemmin@microsoft.com>, Sven Schnelle <svens@stackframe.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Wei Liu <wei.liu@kernel.org>, 
	Wei Xu <xuwei5@hisilicon.com>, Will Deacon <will@kernel.org>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, 
	"list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, iommu@lists.linux.dev, 
	linux-alpha@vger.kernel.org, 
	linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, 
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, linux-ia64@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	"open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, linux-parisc@vger.kernel.org, 
	linux-pci <linux-pci@vger.kernel.org>, Linux-SH <linux-sh@vger.kernel.org>, 
	linux-xtensa@linux-xtensa.org, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20220703150458.CRUJU_CzRlSUdMjmK7Gdk97oemt5SaUOQgRCRPG_rC4@z>

On Fri, Jul 1, 2022 at 10:01 PM Samuel Holland <samuel@sholland.org> wrote:
>
> Now that the irq_data_update_affinity helper exists, enforce its use
> by returning a a const cpumask from irq_data_get_affinity_mask.
>
> Since the previous commit already updated places that needed to call
> irq_data_update_affinity, this commit updates the remaining code that
> either did not modify the cpumask or immediately passed the modified
> mask to irq_set_affinity.

When we refer to functions, we use parentheses, e.g. func().

-- 
With Best Regards,
Andy Shevchenko
