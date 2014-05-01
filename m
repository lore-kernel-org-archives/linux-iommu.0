From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v12 30/31] ARM: dts: add System MMU nodes of exynos5250
Date: Thu, 01 May 2014 23:16:26 +0900
Message-ID: <20140501231626.fd15cca4a30891f81c953a44@samsung.com>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
	<1398584283-22846-31-git-send-email-shaik.ameer@samsung.com>
	<CAGm_ybhTEN9QxFBd1Su8NGP32KeYTF8d_Z8gXKo7cYpapZrA9w@mail.gmail.com>
	<CAD=FV=UCpQRg9nWu5EfuzWmBpee9N3X6yCmtpRaNQxitfFZkMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <CAD=FV=UCpQRg9nWu5EfuzWmBpee9N3X6yCmtpRaNQxitfFZkMQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Vikas Sajjan <sajjan.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-samsung-soc <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Shaik Ameer Basha <shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Prathyush <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, supash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, Abhilash Kesavan <a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, sunil joshi <joshi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, RAHUL SHARMA <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, 28 Apr 2014 16:13:19 -0700, Doug Anderson wrote:
> Vikas,
> 
> 
> On Sun, Apr 27, 2014 at 10:39 AM, Vikas Sajjan <sajjan.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > Hi shaik,
> >
> > +Doug, Abhilash,
> >
> > On Sun, Apr 27, 2014 at 1:08 PM, Shaik Ameer Basha
> > <shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> >> From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> >>
> >> Signed-off-by: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> >> ---
> >>  arch/arm/boot/dts/exynos5250.dtsi |  270 ++++++++++++++++++++++++++++++++++++-
> >>  1 file changed, 267 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> >> index 3742331..eebd397 100644
> >> --- a/arch/arm/boot/dts/exynos5250.dtsi
> >> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> >> @@ -82,6 +82,16 @@
> >>                 reg = <0x10044040 0x20>;
> >>         };
> >>
> >> +       pd_isp: isp-power-domain@0x10044020 {
> >> +               compatible = "samsung,exynos4210-pd";
> >> +               reg = <0x10044020 0x20>;
> >> +       };
> >> +
> >> +       pd_disp1: disp1-power-domain@0x100440A0 {
> >> +               compatible = "samsung,exynos4210-pd";
> >> +               reg = <0x100440A0 0x20>;
> >> +       };
> >> +
> >
> > As per subject "add System MMU nodes of exynos5250", it should only
> > add SysMMU node.
> > So, I think adding power domain nodes should go in a separate patch.
> >
> > Adding power domain nodes can break the system, if powering ON/OFF of
> > the given power domain is NOT taken care well.
> > I can see ISP is one such case. With this series I can see S2R breaks
> > [1] on 5250 chromebook with current mainline kernel (same applies for
> > arndale and smdk5250, but I have tested on these boards yet)
> 
> Thanks for catching that!  Let's make sure not to break suspend/resume.
> 
> Given that these power domains are actually used as the domains for
> some of the System MMU nodes I don't totally object to adding them in
> the same patch, but if they're breaking things then I agree that we
> could leave them out and add them in a later patch (once issues are
> sorted out).
> 

Thank you, Vikas.

Let me consider adding ISP power doamin after checking
power down sequence of ISP domain.

KyongHo
