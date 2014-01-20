From: Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
Subject: Re: PROBLEM: do_IRQ: [number] No irq handler for vector (irq -1)
Date: Mon, 20 Jan 2014 07:26:30 -0500
Message-ID: <20140120122630.GB22690@hmsreliant.think-freely.org>
References: <52D576E3.8050006@metrics.net>
	<1389844985.8705.45.camel@bling.home>
	<20140116121617.GA9984@hmsreliant.think-freely.org>
	<52D8120D.7090606@metrics.net>
	<20140116182134.GC9984@hmsreliant.think-freely.org>
	<52D83BF9.7040502@metrics.net>
	<20140117140831.GA19452@hmsreliant.think-freely.org>
	<52D97BFB.1020106@metrics.net>
	<20140117202712.GC19452@hmsreliant.think-freely.org>
	<52D9AFBB.5080203@metrics.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52D9AFBB.5080203-VnMYzjHJ8tfR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Anthony DeRobertis <aderobertis-VnMYzjHJ8tfR7s880joybQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Jan 17, 2014 at 05:33:31PM -0500, Anthony DeRobertis wrote:
> On 01/17/2014 03:27 PM, Neil Horman wrote:
> 
> >I would suggest you look through that errata sheet that I
> >referenced in the initial commit to fix the remapping problem, to
> >see if there are other chip errata who's symptoms lead to irq
> >drainage failures. We may need to add another quirk to this
> >chipset. Regards Neil
> 
> OK, I started looking through the errata sheet. Let me stress I
> don't normally read these things, so...
> 
> But the first thing I notice is that I tried to figure out what
> stepping I have (in the Identification section), it says should look
> for vendor ID 8086h and device ID 3403 or 3406. I have neither. I
> have 3405.
> 
> Which, appears to make sense, because this is not a Intel 5500/5520
> chipset, its an Intel X58 chipset. That seems to have a different
> specification update, despite being from the same family:
> 
> http://www.intel.com/content/dam/doc/specification-update/x58-express-specification-update.pdf
> 
> 00:00.0 Host bridge [0600]: Intel Corporation 5520/5500/X58 I/O Hub to ESI Port [8086:3405] (rev 13)
> 
> so I have a X58, Stepping B3. Appears to be issue 69 instead, and is
> supposed to happen on B3. Added back in July '09. Odd that Asus
> hasn't yet heard... Especially since they didn't release the board
> until 2010.
> 
Right, the X58 variant of the chipset should be covered by
803075dba31c17af110e1d9a915fe7262165b213.  And it is, because we still get the
remapping warning when you boot up.  Whats odd is that you're still seeing the
issue, so there must be something else about your chipset that acting
differently than other X58's

> [Still trying to make my way through those documents.]
> 
> PS: The linked bug report
> https://bugzilla.redhat.com/show_bug.cgi?id=887006 is apparently
> secret :-(
> 
That bug is mine, it just tracks the resolution of this problem on the 55XX
chipsets in RHEL6.  You know everything there is to know in that bug :)
Neil
