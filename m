From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH v4 00/12] iommu/exynos: Fixes and Enhancements of System
 MMU driver with DT
Date: Fri, 30 Nov 2012 19:55:30 +0900
Message-ID: <1d6601cdcee9$36ebd760$a4c38620$%kim@samsung.com>
References: <002101cdc8a4$fc375990$f4a60cb0$%cho@samsung.com>
 <112e01cdc951$976699b0$c633cd10$%kim@samsung.com>
 <008601cdce20$1ccffb00$566ff100$%cho@samsung.com>
 <CAPdUM4M77LGQn+FcxmsA38H9wrJX6to_OgmtkSgUYkXVuD-m2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAPdUM4M77LGQn+FcxmsA38H9wrJX6to_OgmtkSgUYkXVuD-m2w@mail.gmail.com>
Content-language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: 'Rahul Sharma' <r.sh.open@gmail.com>, 'Cho KyongHo' <pullip.cho@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, prathyush.k@samsung.com, sw0312.kim@samsung.com, 'Subash Patel' <subash.ramaswamy@linaro.org>, 'Sanghyun Lee' <sanghyun75.lee@samsung.com>, rahul.sharma@samsung.com
List-Id: iommu@lists.linux-foundation.org

Rahul Sharma wrote:
>
> Hi Mr. Cho,
> 
> We have verified the above patchset for following usecases on exynos5.
> 
> 1) MFC decoding using Sysmmu_L and R. (with the bit Inversion fix)
> 2) GSC operations.
> 3) FIMD and MIXER (HDMI) as displays.
> 
> Thanks for your effort.
> 
Thanks for your test on board.

[...]

> >> > >
> >> > > Looks good to me 1st~3rd patches. After quick review, I think, 1st
> and 2nd
> >> > > patches can go to upstream for v3.8 without any dependency. So I
> will.
> >> > >
> >> > > The 3rd patch has a dependency with other driver changes (4th ~
> 12th), so it
> >> > > should be sent to upstream with others.
> >> > >
> >> > > BTW since the 3rd patch touches many Samsung stuff in arch/arm/ so
> I'd
> >> > > prefer to take it in Samsung tree. If Joerg is ok on iommu/exynos
> driver
> >> > > changes for v3.8...
> >> > >
> >> > > Joerg, please let me know about iommu/exynos stuff so that I can
> decide to
> >> > > take 3rd patch or not for v3.8.
> >> > >
> >> >
> >> > Hi, Kukjin Kim.
> >> >
> >> > I found that control bit fields of clock gating of System MMU of MFC
> L/R is inversed.
> >> > That is reported by Prathyush Kalashwaram.
> >> >
> >> > I will post v5 patchset that solves this.
> >> >
> >>
> >> I did not posted v5 patchset.
> >> Instead, I posted just the fix for the 03/12 patch mentioned above
> >> as the reply to the 03/12 patch.
> >>
> >
> > Hi, Joerg.
> >
> > I am waiting for your comment about the patchset.

Same here.

> > The latest version is v4.
> > And a fix of [patch v4 03/12] mentioned above is posted as a reply.
> >
> > If you have any concern about the patches, please let me know
> >

If there is no reply, as I said, I will apply 1st and 2nd patches...

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
