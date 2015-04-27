From: Linda Knippers <linda.knippers-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [GIT PULL] Intel IOMMU for 4.1
Date: Mon, 27 Apr 2015 12:09:47 -0400
Message-ID: <553E5F4B.6020208@hp.com>
References: <1430038266.4833.14.camel@infradead.org>	<1430069591.8301.91.camel@redhat.com>	<1430070924.13479.5.camel@infradead.org>	<1430072207.8301.103.camel@redhat.com>	<553E4109.5060903@hp.com>	<1430149195.4472.43.camel@redhat.com>
	<CA+55aFx+QhMZpCtnG2sHib+kk5BR+PeEa99-CCushSA5oAqVxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CA+55aFx+QhMZpCtnG2sHib+kk5BR+PeEa99-CCushSA5oAqVxw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 4/27/2015 11:48 AM, Linus Torvalds wrote:
> On Mon, Apr 27, 2015 at 8:39 AM, Alex Williamson
> <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>>
>> Since this got pulled anyway, do you plan to follow-up with patches to
>> limit the graphics RMRR exception to the known and acceptable uses and
>> document them, or should I send a revert patch?  I don't think what we
>> have here is acceptable going forward or being backported to stable.
>> Thanks,
> 
> Does anybody actually *care* about RMRR?

I care, just not so much for GPUs.

> The thing is shit. We know it's shit. We already had Linda pipe up to
> tell us that there are bogus RMRR's for ever slot in older machines.

I'd call them unnecessary.

> And we already ignore RMRR for USB controllers because it was just
> useless garbage.
> 
> Is there any reason to *not* just ignore RMRR for all video devices
> like we do now? Seriously?

I was only speaking about one particular use case of RMRR for video
devices.  I'm not sure what anyone else is doing with them.

> I'm *so* not impressed with firmware tables. These things are always
> uniformly wrong. We should strive to generate the information from our
> actual hardware knowledge, with BIOS tables being the absolutely least
> trusted source of information.

In some cases though, you really do need the firmware to provide the tables.
Too few RMRRs are worse than too many.

-- ljk
> 
>                      Linus
> 
