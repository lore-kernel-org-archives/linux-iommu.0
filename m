From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: Any side effect if turn off amd_iommu
Date: Wed, 13 May 2015 15:44:39 +0200
Message-ID: <20150513134439.GJ20611@8bytes.org>
References: <CAFv23Qn93z4pE6RtURgoiBADpgCWZ6gfpMPn3akfJibudRi+Qg@mail.gmail.com>
	<20150326120547.GU4441@8bytes.org>
	<CAFv23QnUO+w0EXUx8DtgPx0W=fz37_R04EW6P-g+PF_y_U1dfA@mail.gmail.com>
	<20150330160910.GZ4441@8bytes.org>
	<CAFv23QmOjFb9NgLY0aW55OpQSecFA83jNOU1TY7o3qWuft1_Cw@mail.gmail.com>
	<CAFv23Q==+tXTif9uQfyTHE28hxGt80WYS=A6qN7q0Q4q7re6kw@mail.gmail.com>
	<20150504110802.GE15736@8bytes.org>
	<CAFv23QkRouVJ6siu==-EjLndP2Z7inz+qVeKxLci3=R=9r8+zQ@mail.gmail.com>
	<20150505151319.GO15736@8bytes.org>
	<CAFv23Q=iU7X1EOcZDUh6NhcnuvyyNSKUGEot6ZhCg8uZ7kRNAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAFv23Q=iU7X1EOcZDUh6NhcnuvyyNSKUGEot6ZhCg8uZ7kRNAQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: AceLan Kao <acelan.kao-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi AceLan Kao,

On Wed, May 13, 2015 at 03:37:57PM +0800, AceLan Kao wrote:
> The method I described is not making any guess, we need a table to
> write down the correct ioapic value for those machines, we can add the
> BIOS version check(DMI_BIOS_VERSION) if you think the behavior may
> change with different version of BIOSes.

You don't know which IO-APIC is which one without a correct IVRS table.
AMD desktop systems have usually have up to two IO-APICs, one in the SB
and one in the NB. But the ids of these IO-APICs are not fixed and
can depend on the BIOS version as well as on the processor that is
plugged into the board. So since we don't know which IO-APIC is which
one we can't make any good guesses that work for everybody. When we
implement workarounds we may fix it for one user, but risk breakage for
others.

> If you still feel uncomfortable, I'm okay with any solutions, but I
> don't get it how to do it in your way.
> We can found those machines from bug reports(I have some machines on
> my hand, too), so we need a table to record those machines? And how to
> disable interrupt remapping, will it lead to any side effect?

Disabling interrupt remapping has no big side effect. You only have to
load vfio with a special parameter so allow unsafe interrupts to do
device assignment with KVM.


	Joerg
