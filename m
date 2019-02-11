From: Tianyu Lan <lantianyu1986@gmail.com>
Subject: Re: [PATCH V3 2/3] HYPERV/IOMMU: Add Hyper-V stub IOMMU driver
Date: Mon, 11 Feb 2019 16:21:14 +0800
Message-ID: <CAOLK0pyHt3pCiEA4nnrHLXc7gvbB0+vN3_aA+_D27KUi_Dkvdw@mail.gmail.com>
References: <1549553629-8414-1-git-send-email-Tianyu.Lan@microsoft.com>
 <1549553629-8414-3-git-send-email-Tianyu.Lan@microsoft.com> <20190208145159.GA17854@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190208145159.GA17854@aepfle.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>
Cc: Lan Tianyu <Tianyu.Lan@microsoft.com>, "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org, michael.h.kelley@microsoft.com, kys@microsoft.com, Vitaly Kuznetsov <vkuznets@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Sasha Levin <sashal@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: iommu@lists.linux-foundation.org

Hi Olaf:
             Thanks for your review.

On Fri, Feb 8, 2019 at 10:52 PM Olaf Hering <olaf@aepfle.de> wrote:
>
> On Thu, Feb 07, lantianyu1986@gmail.com wrote:
>
> > +++ b/drivers/iommu/Kconfig
> > +config HYPERV_IOMMU
> > +     bool "Hyper-V x2APIC IRQ Handling"
> > +     depends on HYPERV
> > +     select IOMMU_API
> > +     help
>
>
> Consider adding 'default HYPERV' like some other drivers already do it.
>
> Olaf

Good suggestion and will update. Thanks.

-- 
Best regards
Tianyu Lan
