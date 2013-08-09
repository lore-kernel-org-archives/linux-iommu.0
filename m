From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v8 06/12] ARM: dts: Add description of System MMU of Exynos
	SoCs
Date: Fri, 09 Aug 2013 11:24:36 +0900
Message-ID: <20130809112436.8e44545cd503ca5a2b55a8cd@samsung.com>
References: <003c01ce89f3$3abc4bc0$b034e340$@samsung.com>
	<003801ce8eb7$d7647f10$862d7d30$@samsung.com>
	<CAL_Jsq+_5GekzXpjWrtKZi2jWuxHSJxkPmVC4zmakfjAYai=eA@mail.gmail.com>
	<5354557.DijgoUKjW2@flatron>
	<20130808214343.GA19383@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <20130808214343.GA19383-MRww78TxoiP5vMa5CHWGZ34zcgK1vI+I0E9HWUfgJXw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Linux Samsung SOC <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hyunwoong Kim <khw0178.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Prathyush <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Keyyoung Park <keyyoung.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Subash Patel <supash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org" <kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org>, Linux ARM Kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Rahul Sharma <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, 08 Aug 2013 22:43:43 +0100, Will Deacon wrote:
> On Thu, Aug 08, 2013 at 10:38:10PM +0100, Tomasz Figa wrote:
> > On Thursday 08 of August 2013 08:09:49 Rob Herring wrote:
> > > On Thu, Aug 1, 2013 at 8:05 AM, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> 
> > wrote:
> > > > Should this align with ARM System MMU bindings?
> > > > System MMU in Exynos SoC is different from ARM System MMU.
> > > > It does not follows the specifications of ARM System MMU.
> > > 
> > > I'm not saying the h/w is the same or even the same spec, but how you
> > > describe a master to iommu connection needs to be done in the same
> > > way. This should be done in the same way for ALL iommu's. And if what
> > > is defined does not work for you, then we need to understand that and
> > > fix the binding now.
> > 
> > +1
> > 
> > All IOMMUs should use a generic IOMMU Device Tree bindings (and in 
> > general, the same should be true for all Device Tree bindings).
> > 
> > This means that if we already have some bindings for IOMMU, then they 
> > should be reused if possible or extended if there is anything missing.
> > 
> > Of course there might be things that such generic bindings can't specify. 
> > In this case device-specific properties can be introduced, but this is 
> > last resort.
> 
> I'm also happy to discuss and/or review bindings in light of what we did for
> the ARM SMMU.
> 
> Will

Rob, I now understood what you are talking about.
Do you mean the binding description is lack of details about connection
betwen  System MMU and its master?

thanks.

KyongHo.
