From: Shuah Khan <shuah.khan-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [PATCH v2] Intel IOMMU patch to reprocess RMRR info
Date: Fri, 28 Sep 2012 13:35:29 -0600
Message-ID: <1348860929.2601.30.camel@lorien2>
References: <uh6q9m8bwu6c2jov69m2aivu.1348847561292@email.android.com>
	<5065D1F5.1090003@hp.com>
	<1348859719.2036.128.camel@shinybook.infradead.org>
Reply-To: shuah.khan-VXdhtT5mjnY@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1348859719.2036.128.camel-Fexsq3y4057IgHVZqg5X0TlWvGAXklZc@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, shuah.khan-VXdhtT5mjnY@public.gmane.org, "Mingarelli,
	Thomas" <Thomas.Mingarelli-VXdhtT5mjnY@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, 2012-09-28 at 20:15 +0100, David Woodhouse wrote:
> On Fri, 2012-09-28 at 12:36 -0400, Linda Knippers wrote:
> > I can only speak to the HP servers.  We have been shipping devices
> > 'for a while' that provide sensor-type data to the platform.  The
> > device does DMA writes to a range of memory (the RMRR) and
> > iLO does DMA reads of that data.
> > 
> > This works in general but not when the 'iommu=pt' boot option is
> > used.  This patch associates the RMRR with the devices when
> > they are moved out of the "si" domain.
> 
> That much makes sense, I think, because they're moved out of the
> hardware SI domain *early*, when we realise they're actually only
> capable of 32-bit DMA and we have >4GiB of RAM. Right?

Correct. By default all devices are added to SI domain assuming that
these devices are 64-bit devices. When we detect the device is a 32-bit
device based on the requested dma-mask, it gets removed from SI domain,
hence looses its RMRR association. In the meantime dma continues causing
DMA errors. This patch is re-processing RMRRs for the device in question
and doing re-assignment.

> 
> It sounds like this isn't a case of the device being used by a native
> driver or given to KVM, and subsequently released. This is just booting
> up and losing the RMRR regions on a device which the OS *hasn't* really
> touched. So that should be fixed.
> 
> > Based on Alex's comments about moving RMRR devices between domains,
> > it sounds like we also have a problem without the 'iommu=pt' boot
> > option if someone assigns one of those devices to a guest.
> 
> Yeah... but why *would* they? What possible reason would we have to
> assign either the sensor device, or the iLO, to a KVM guest. Or to have
> a native driver that attempts to do DMA from them?
> 
> Obviously, in an ideal world we'd have proper native drivers for the
> sensor device. But I'm guessing that's not the case here; it's used by
> the firmware and we're not supposed to be touching it?
> 
> And yes, obviously a better hardware design (from the OS/IOMMU point of
> view) would be to have a path for the sensor data that *doesn't* go via
> host RAM and thus via the IOMMU twice. But while that's a lesson that's
> hopefully been learned and will be implemented in future, we have to
> deal with the existing hardware and its (ab)use of RMRRs.
> 

Right. We do have hardware that is relying on being able to do dma from
devices to a system RAM via RMRR.

-- Shuah
