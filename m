From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: SMMU 2-stage support
Date: Wed, 15 Apr 2015 17:17:40 +0100
Message-ID: <20150415161739.GD18864@arm.com>
References: <CAN9JPjFf1Lb+L8sWq0SWt8f6P6DX2i308OeF+TdnFdstRoU3hA@mail.gmail.com>
	<20150218185600.GN22017@arm.com>
	<CAN9JPjFvg=e948ZLLtrUTnvDp8UWHCX2NGB4iUEES733T9YytQ@mail.gmail.com>
	<20150413104122.GC2869@arm.com>
	<BN3PR0301MB12194C697DBE9D721BC97F5DEAE60@BN3PR0301MB1219.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <BN3PR0301MB12194C697DBE9D721BC97F5DEAE60-CEkquS/Gb81uuip9JPHoc5wN6zqB+hSMnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Stuart Yoder <stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 14, 2015 at 02:32:26PM +0100, Varun Sethi wrote:
> Hi Will,

Hey Varun,

> > -----Original Message-----
> > From: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org [mailto:iommu-
> > bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org] On Behalf Of Will Deacon
> > Sent: Monday, April 13, 2015 4:11 PM
> > To: Baptiste Reynal
> > Cc: Linux IOMMU
> > Subject: Re: SMMU 2-stage support
> > 
> > On Fri, Apr 03, 2015 at 10:55:02AM +0100, Baptiste Reynal wrote:
> > > We are eventually working on the vSMMU implementation. Relying on the
> > > talk Will Deacon gave at the Linux Plumbers IOMMU Microconference on
> > > October
> > > 2014 (http://linuxplumbersconf.org/2014/ocw/proposals/2019), I tried
> > > the vSMMU initialization.
> > 
> > My position on the vSMMU still hasn't changed:
> > 
> > > > Anyway, until somebody actually wants this feature I've put it on
> > > > ice as it adds a whole bunch of complication to the ARM SMMU driver,
> > > > as well as new user ABI extensions that I don't really want to maintain for
> > fun.
> > 
> > So, whilst it's great that you're looking at the code, I'm not very keen on
> > merging anything until we have people committed to using it. Right now, the
> > only feedback I've had has been going in the para-virt direction and I don't
> > think we should do this "for fun".
> Freescale would be interested in using the vSMMU implementation. We have
> use cases for assigning devices to guest user space. Are you suggesting
> that you are more inclined to using the para virtualized approach?

I can see arguments either way; the vSMMU means that the guest can use the
same SMMU driver as the host but a para-virtualised approach could
theoretically be used across multiple SMMU implementations as well as
potentially being kinder on the TLB.

Will
