From: Cho KyongHo <pullip.cho@samsung.com>
Subject: RE: [PATCH] iommu/exynos: Remove driver
Date: Fri, 14 Feb 2014 09:17:25 +0900
Message-ID: <001301cf291a$233fdc70$69bf9550$@samsung.com>
References: <1391716317-20300-1-git-send-email-olof@lixom.net>
 <CAAQKjZMo6=dtur6NfvDY9=jVF=7VxHub=isnEwPw0+RKCq6xAg@mail.gmail.com>
 <CAH9JG2Xoz1_Y7CV6FUiGAO9o5T7jtFUYqJpcAysLttwu4527zQ@mail.gmail.com>
 <52F4E481.3050902@samsung.com>
 <CAL5jtJmfwajFD0cnYt6gOfFsZ5hGbFi=5kv8g4x23fY6qGBOew@mail.gmail.com>
 <CAOesGMhH2WHvkaobewdnPeiThrWTfw0m4WWAZW98-iS2xdr+ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CAOesGMhH2WHvkaobewdnPeiThrWTfw0m4WWAZW98-iS2xdr+ow@mail.gmail.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Olof Johansson' <olof@lixom.net>, 'Kukjin Kim' <kgene.kim@gmail.com>
Cc: 'Marek Szyprowski' <m.szyprowski@samsung.com>, 'Kyungmin Park' <kmpark@infradead.org>, 'Inki Dae' <inki.dae@samsung.com>, linux-samsung-soc@vger.kernel.org, 'Bartlomiej Zolnierkiewicz' <b.zolnierkie@samsung.com>, 'Joerg Roedel' <joro@8bytes.org>, iommu@lists.linux-foundation.org, 'Sean Paul' <seanpaul@chromium.org>, 'Tomasz Figa' <t.figa@samsung.com>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

> -----Original Message-----
> From: Olof Johansson [mailto:olof@lixom.net]
> Sent: Friday, February 14, 2014 4:34 AM
> 
> On Mon, Feb 10, 2014 at 10:21 PM, Kukjin Kim <kgene.kim@gmail.com> wrote:
> 
> > Just adding KyongHo Cho.
> >
> > If he can fixup for this time, it would be best solution because he knows
> > well than others, I think.
> 
> It's not so much a matter of "fixup for this time", it's a about
> having ownership of the driver, making sure it works (and keeps
> working if there is related development). The posted patches have not
> been followed through on and the result is a broken driver. :(
> 
> I definitely appreciate his expertise, and we should make sure that he
> gets to review the code, but if someone else is able to spend time on
> reworking the driver (or rewriting a newer one) and maintaining it
> longer-term, then we should not stop them from doing so. And there is
> no reason to keep broken stale code in the kernel meanwhile.
> 

Thank you for your concerning.
I also definitely agree with you that the driver must work.
I am always concerning about it but it was not easy to make some time
for the patches.

I will continue to post the next version of patches, of course.
I think it is not far from now to show it.

Regards,

Ky0ongHo
