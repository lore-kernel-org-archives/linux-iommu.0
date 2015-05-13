From: AceLan Kao <acelan.kao-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Subject: Re: Any side effect if turn off amd_iommu
Date: Wed, 13 May 2015 15:37:57 +0800
Message-ID: <CAFv23Q=iU7X1EOcZDUh6NhcnuvyyNSKUGEot6ZhCg8uZ7kRNAQ@mail.gmail.com>
References: <CAFv23QmxQ3vJnMEGN0TNR3vLAx1MN7ptB0y3QQLKciqfT3OBsQ@mail.gmail.com>
	<20150325140410.GS4441@8bytes.org>
	<CAFv23Qn93z4pE6RtURgoiBADpgCWZ6gfpMPn3akfJibudRi+Qg@mail.gmail.com>
	<20150326120547.GU4441@8bytes.org>
	<CAFv23QnUO+w0EXUx8DtgPx0W=fz37_R04EW6P-g+PF_y_U1dfA@mail.gmail.com>
	<20150330160910.GZ4441@8bytes.org>
	<CAFv23QmOjFb9NgLY0aW55OpQSecFA83jNOU1TY7o3qWuft1_Cw@mail.gmail.com>
	<CAFv23Q==+tXTif9uQfyTHE28hxGt80WYS=A6qN7q0Q4q7re6kw@mail.gmail.com>
	<20150504110802.GE15736@8bytes.org>
	<CAFv23QkRouVJ6siu==-EjLndP2Z7inz+qVeKxLci3=R=9r8+zQ@mail.gmail.com>
	<20150505151319.GO15736@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150505151319.GO15736-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

The method I described is not making any guess, we need a table to
write down the correct ioapic value for those machines, we can add the
BIOS version check(DMI_BIOS_VERSION) if you think the behavior may
change with different version of BIOSes.

If you still feel uncomfortable, I'm okay with any solutions, but I
don't get it how to do it in your way.
We can found those machines from bug reports(I have some machines on
my hand, too), so we need a table to record those machines? And how to
disable interrupt remapping, will it lead to any side effect?

Best regards,
AceLan Kao.

2015-05-05 23:13 GMT+08:00 Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>:
> Hi,
>
> On Tue, May 05, 2015 at 03:30:41PM +0800, AceLan Kao wrote:
>> There is no easy way to check whether this BIOS bug is present, so we
>> have to list them explicitly.
>> I think we can do just like what platform drivers(ex. asus_quirks[1])
>> do, check the system vendor and product name to identify those
>> machines, and give them a working ioapic value.
>
> Problem here is that system vendor and platform name is not enough, the
> version of the BIOS is also important. To make things worse, the problem
> could be introduced into one BIOS version and fixes in another later
> version.
>
> My feeling is that trying to make guesses here will open a can of
> worms we better keep closed. The strategy for now has been to search for
> broken configurations and disable interrupt remapping when they are
> detected.
>
>
>         Joerg
>
