From: Linda Knippers <linda.knippers-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [PATCH v2] Intel IOMMU patch to reprocess RMRR info
Date: Fri, 28 Sep 2012 12:36:05 -0400
Message-ID: <5065D1F5.1090003@hp.com>
References: <uh6q9m8bwu6c2jov69m2aivu.1348847561292@email.android.com>
Reply-To: linda.knippers-VXdhtT5mjnY@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <uh6q9m8bwu6c2jov69m2aivu.1348847561292-2ueSQiBKiTY7tOexoI0I+QC/G2K4zDHf@public.gmane.org>
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
Cc: "Khan, Shuah" <shuah.khan-VXdhtT5mjnY@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "Mingarelli, Thomas" <Thomas.Mingarelli-VXdhtT5mjnY@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

David Woodhouse wrote:
> 
> HP may have been shipping such things 'for a while' but it's never
> actually worked right, yes? This thread is about the patch that's
> intended to *fix* that?

I can only speak to the HP servers.  We have been shipping devices
'for a while' that provide sensor-type data to the platform.  The
device does DMA writes to a range of memory (the RMRR) and
iLO does DMA reads of that data.

This works in general but not when the 'iommu=pt' boot option is
used.  This patch associates the RMRR with the devices when
they are moved out of the "si" domain.

Based on Alex's comments about moving RMRR devices between domains,
it sounds like we also have a problem without the 'iommu=pt' boot
option if someone assigns one of those devices to a guest.

Tom, Shuah, Alex - please correct me if I've gotten any of this wrong.

> If they could just manage to make their firmware-owned DMA appear to be
> from a different PCIe device/function from the one the OS gets to own,
> that would make things "just work", right? Hell, their laptops already
> have Ricoh multi-function devices that do their DMA  from the 'wrong'
> function.... take that concept and make it useful...
> 
> If the DMA could be hidden from the IOMMU altogether, all the better.
> But at least coming from its own dedicated devfn would avoid the issues
> this patch attempts to solve.

That does sound like a good idea and may be something that we can suggest
for the future but that won't help us today.

If we address Alex's comments and we make a change to disallow the
devices (non-USB devices?) with RMRRs from being assigned to
a guest, will those changes be considered?

-- ljk
> 
> 
> 
> -- 
> dwmw2
> 
> (Apologies for HTML and top-posting; Android mailer is broken.)
> 
> Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> On Fri, 2012-09-28 at 14:52 +0200, Joerg Roedel wrote:
>> On Fri, Sep 28, 2012 at 06:40:08AM -0600, Alex Williamson wrote:
>> > On Fri, 2012-09-28 at 11:43 +0200, Joerg Roedel wrote:
>>
>> > > I don't think so. The concept of RMRR is just not defined well enough
>> > > (like the concept of unity mappings on the AMD side which is
> similar to
>> > >  RMRR). The definition says, that any memory region must be mapped at
>> > > any time for the device. But that is not true (at least I have no
>> > > counter-example yet). The right definition would be, that the RMRR
>> > > regions are only necessary as long as the operating system does not
>> > > control the particular device. And assigning a device to a guest also
>> > > counts a 'taking control over the device'.
>> >
>> > I think HP folks would be very unhappy with that definition.  As David
>> > indicates, that's how things like USB use RMRR, but the actual
>> > definition in the spec leaves much more room for abuse.  Thanks,
>>
>> To my experience, for a hardware designer, existing software overrides
>> any Spec because it is much worse to break existing software than it is
>> to break a Spec :) So, unless we break existing hardware/firmware, I
>> still suggest that we use the assumption that OS controlled devices do
>> not need RMRR/unity-mapped regions anymore.
> 
> HP has been shipping hardware that makes use of RMRRs for other purposes
> for a while.
> 
>> Is HP doing anything in their firmware which would not work with that?
> 
> Yes, I'll let them fill in the details.
> 
>> For the USB controlers, they only generate DMA to the RMRR/unity-mapped
>> region until the OS takes over control from the firmware. After
>> the USB driver is initialized the RMRR region should not be necessary
>> anymore.
> 
> I agree that was probably the intent, but vendors have found loopholes
> as their opportunity to innovate.  Thanks,
> 
> Alex
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
