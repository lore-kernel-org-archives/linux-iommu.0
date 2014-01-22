From: Anthony DeRobertis <aderobertis-VnMYzjHJ8tfR7s880joybQ@public.gmane.org>
Subject: Re: PROBLEM: do_IRQ: [number] No irq handler for vector (irq -1)
Date: Wed, 22 Jan 2014 11:29:50 -0500
Message-ID: <52DFF1FE.2080805@metrics.net>
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
	<20140120122630.GB22690@hmsreliant.think-freely.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140120122630.GB22690-B26myB8xz7F8NnZeBjwnZQMhkBWG/bsMQH7oEaQurus@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 01/20/2014 07:26 AM, Neil Horman wrote:
> Right, the X58 variant of the chipset should be covered by
> 803075dba31c17af110e1d9a915fe7262165b213.  And it is, because we still ge=
t the
> remapping warning when you boot up.  Whats odd is that you're still seein=
g the
> issue, so there must be something else about your chipset that acting
> differently than other X58's

Indeed. X58 isn't exactly a weird chipset, I can't be the only person =

with it...

I've gone back to booting with my patch (the one which removes/disables =

the quirk). and it continues to work fine. As long as I ignore Intel's =

erratum.

I'm not sure where to look next. Going to throw some random printk's in, =

but I stress random=97I'm not familiar with the code or the hardware. =

Suggestions of what to try next appreciated.
