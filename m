From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH 4/7] iommu: provide helper function to configure an
	IOMMU for an of master
Date: Wed, 3 Sep 2014 10:45:47 +0100
Message-ID: <20140903094547.GB32378@arm.com>
References: <1409327670-3495-1-git-send-email-will.deacon@arm.com>
	<3424322.yoZKhlAsy0@wuerfel> <20140902130508.GK25379@arm.com>
	<5897964.3ztXLVfPDF@wuerfel> <20140902205941.GA26123@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140902205941.GA26123-l3A5Bk7waGM@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Sep 02, 2014 at 09:59:41PM +0100, jroedel-l3A5Bk7waGM@public.gmane.org wrote:
> On Tue, Sep 02, 2014 at 04:01:32PM +0200, Arnd Bergmann wrote:
> > This is an artifact of the API being single-instance at the moment.
> > We might not in fact need it, I was just trying to think of things
> > that naturally fit in there and that are probably already linked
> > together in the individual iommu drivers.
> 
> I am not sure what you mean by single-instance. Is it that currently the
> API only supports one type of iommu_ops per bus? That should be fine as
> long as there is only one type of IOMMU on the bus.

The problem is really with the platform_bus, which is used as a catch-all
for all the non-probable memory-mapped buses on an SoC. We really want to
have different IOMMU types there.

> Besides that, it is a feature of the IOMMU-API to hide the details about
> all the hardware IOMMUs in the system from its users.

Sure, but even if we have multiple instances of the same IOMMU type, the
complexity in dealing with that is currently pushed down into the drivers,
with each one trying to construct its own notion of topology and master
linkages. Moving some of this into generic code would ease the burden on
IOMMU drivers.

Will
