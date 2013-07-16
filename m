From: Cho KyongHo <pullip.cho@samsung.com>
Subject: RE: [PATCH v7 3/9] iommu/exynos: fix page table maintenance
Date: Tue, 16 Jul 2013 22:07:46 +0900
Message-ID: <002101ce8225$775a71e0$660f55a0$@samsung.com>
References: <002b01ce797b$44d4ad10$ce7e0730$@samsung.com>
 <1933986.4vddYccClk@amdc1032> <009a01ce814d$840b48c0$8c21da40$@samsung.com>
 <CANEJEGs_8a9dPCYtDT8u2NEv5HUUD5gcdmRmbsrKU-_aagztgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CANEJEGs_8a9dPCYtDT8u2NEv5HUUD5gcdmRmbsrKU-_aagztgg@mail.gmail.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Grant Grundler' <grundler@chromium.org>
Cc: 'Bartlomiej Zolnierkiewicz' <b.zolnierkie@samsung.com>, 'Linux ARM Kernel' <linux-arm-kernel@lists.infradead.org>, 'Linux IOMMU' <iommu@lists.linux-foundation.org>, 'Linux Kernel' <linux-kernel@vger.kernel.org>, 'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>, 'Hyunwoong Kim' <khw0178.kim@samsung.com>, 'Joerg Roedel' <joro@8bytes.org>, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Prathyush' <prathyush.k@samsung.com>, 'Rahul Sharma' <rahul.sharma@samsung.com>, 'Subash Patel' <supash.ramaswamy@linaro.org>, 'Keyyoung Park' <keyyoung.park@samsung.com>
List-Id: iommu@lists.linux-foundation.org

> From: grundler@google.com [mailto:grundler@google.com] On Behalf Of Grant Grundler
> Sent: Tuesday, July 16, 2013 1:19 AM
> 
> On Mon, Jul 15, 2013 at 4:21 AM, Cho KyongHo <pullip.cho@samsung.com> wrote:
> ...
> >> Maybe you could add LV1TABLE_SIZE define and use it here (there is
> >> already a LV2TABLE_SIZE define)?
> >
> > Yes. But, LV2TABLE_SIZE is used in more places than one.
> > I do not feel that it is needed to define LV1TABLE_SIZE for the single line.
> 
> Cho,
> #define's are part of the code "documentation". Doesn't really matter
> how often it's used. I think Bartlomiej's suggestion is a good one.
> 
> Key is to use "consistent" names so they makes sense to someone not
> familiar with the code. In this case, we want to show this use is the
> same way LV2TABLE_SIZE is used and serves the same purpose.
> 
Ok.
I agree the error handling code is not pretty to understand.
I will change it in the next patch.

> cheers.
> grant

Thank you.

Cho KyongHo.
