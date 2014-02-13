From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] iommu/exynos: Remove driver
Date: Thu, 13 Feb 2014 11:33:31 -0800
Message-ID: <CAOesGMhH2WHvkaobewdnPeiThrWTfw0m4WWAZW98-iS2xdr+ow@mail.gmail.com>
References: <1391716317-20300-1-git-send-email-olof@lixom.net>
	<CAAQKjZMo6=dtur6NfvDY9=jVF=7VxHub=isnEwPw0+RKCq6xAg@mail.gmail.com>
	<CAH9JG2Xoz1_Y7CV6FUiGAO9o5T7jtFUYqJpcAysLttwu4527zQ@mail.gmail.com>
	<52F4E481.3050902@samsung.com>
	<CAL5jtJmfwajFD0cnYt6gOfFsZ5hGbFi=5kv8g4x23fY6qGBOew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAL5jtJmfwajFD0cnYt6gOfFsZ5hGbFi=5kv8g4x23fY6qGBOew@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@gmail.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kmpark@infradead.org>, Inki Dae <inki.dae@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Joerg Roedel <joro@8bytes.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Sean Paul <seanpaul@chromium.org>, Tomasz Figa <t.figa@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, KyongHo Cho <pullip.cho@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On Mon, Feb 10, 2014 at 10:21 PM, Kukjin Kim <kgene.kim@gmail.com> wrote:

> Just adding KyongHo Cho.
>
> If he can fixup for this time, it would be best solution because he knows
> well than others, I think.

It's not so much a matter of "fixup for this time", it's a about
having ownership of the driver, making sure it works (and keeps
working if there is related development). The posted patches have not
been followed through on and the result is a broken driver. :(

I definitely appreciate his expertise, and we should make sure that he
gets to review the code, but if someone else is able to spend time on
reworking the driver (or rewriting a newer one) and maintaining it
longer-term, then we should not stop them from doing so. And there is
no reason to keep broken stale code in the kernel meanwhile.


-Olof
