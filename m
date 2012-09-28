From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] Intel IOMMU patch to reprocess RMRR info
Date: Fri, 28 Sep 2012 14:03:49 +0200
Message-ID: <20120928120349.GC18962@8bytes.org>
References: <20120918164955.12296.28799.sendpatchset@tmingo.houston.hp.com>
	<1348778200.2320.241.camel@ul30vt.home>
	<9774516974AF5F4C8A2C3C69CD3412332338F452@G1W3651.americas.hpqcorp.net>
	<1348781647.2320.264.camel@ul30vt.home>
	<1348782605.2036.117.camel@shinybook.infradead.org>
	<20120928094625.GI10549@amd.com>
	<1348827803.2036.121.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1348827803.2036.121.camel-Fexsq3y4057IgHVZqg5X0TlWvGAXklZc@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Khan, Shuah" <shuah.khan-VXdhtT5mjnY@public.gmane.org>, "Mingarelli,
	Thomas" <Thomas.Mingarelli-VXdhtT5mjnY@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Sep 28, 2012 at 11:23:23AM +0100, David Woodhouse wrote:
> On Fri, 2012-09-28 at 11:46 +0200, Joerg Roedel wrote:
> > Even on modern hardware with modern (IOMMU aware) kernels there is still
> > this small time window when the OS has enabled the IOMMU and the USB
> > driver is not initialized yet. In this time window the RMRR memory
> > region is still necessary, no?
> 
> Yes but there's no *reason* for that. It wouldn't be that hard to ask
> the firmware to quiesce all its own DMA *before* we enable the IOMMU.

True. That would have been a better approach. Some kind of IOMMU
handover from firmware to the OS.

> > As I said already in another mail, I think it is safe to ignore any RMRR
> > requirements when we start to use a device in the OS.
> 
> I think the whole point in this patch is that there is some brain-dead
> hardware out there (vendor 'value subtract' I think) on which that
> common-sense observation isn't actually true.
> 
> I'm all for handling that broken hardware with quirks, giving clear
> messages to the user that the device(+firmware) in question is broken,
> and refusing to let either the kernel *or* VM guests do any DMA with it.

Well, it is probably mostly about southbridge devices and add-on USB
controllers. Or is there any other way a given device can communicate
RMRR requirements to the firmware?

Anyway, I am fine with completly blocking DMA for those devices too. 


	Joerg
