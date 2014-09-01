From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH 4/7] iommu: provide helper function to configure an
	IOMMU for an of master
Date: Mon, 1 Sep 2014 17:40:00 +0100
Message-ID: <20140901164000.GM24594@arm.com>
References: <1409327670-3495-1-git-send-email-will.deacon@arm.com>
	<1409327670-3495-5-git-send-email-will.deacon@arm.com>
	<20140901082939.GC24430@ulmo> <3729116.F0gWrQGFZl@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3729116.F0gWrQGFZl@wuerfel>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Sep 01, 2014 at 03:46:18PM +0100, Arnd Bergmann wrote:
> On Monday 01 September 2014 10:29:40 Thierry Reding wrote:
> > 
> > I think this could use a bit more formalization. As I said in another
> > reply earlier, there's very little standardization in the IOMMU API.
> > That certainly gives us a lot of flexibility but it also has the
> > downside that it's difficult to handle these abstractions in the core,
> > which is really what the core is all about, isn't it?
> > 
> > One method that worked really well for this in the past for other
> > subsystems is to allow drivers to specify an .of_xlate() function that
> > takes the controller device and a struct of_phandle_args. It is that
> > function's responsibility to take the information in an of_phandle_args
> > structure and use that to create some subsystem specific handle that
> > represents this information in a way that it can readily be used.
> 
> Yes, good idea.

Hmm, how does this work for PCI devices? The current RFC takes care to
ensure that the core changes work just as well for OF devices as PCI
devices, and the of-specific functions and data structures are not part of
it.

Will
