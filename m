From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 4/4] thunderbolt: Export IOMMU based DMA protection
	support to userspace
Date: Tue, 13 Nov 2018 18:12:58 +0200
Message-ID: <20181113161258.GE2500@lahna.fi.intel.com>
References: <20181112160628.86620-1-mika.westerberg@linux.intel.com>
	<20181112160628.86620-5-mika.westerberg@linux.intel.com>
	<CA+CmpXvZJFk=kYvZybgTtqDWBVP_jSE37tdkQbyGA8U9WOrkoQ@mail.gmail.com>
	<20181113105558.GR2500@lahna.fi.intel.com>
	<CA+CmpXtre+A-sNT0XBWfdkuq9xJ+j34EGZ0nEpahJCSe3Kvg9A@mail.gmail.com>
	<20181113114020.GV2500@lahna.fi.intel.com>
	<CA+CmpXt1cfqjz94=WsggKpNCUw3761-cewa_HTa0ETcYK7o+Hw@mail.gmail.com>
	<20181113152038.GD2500@lahna.fi.intel.com>
	<CA+CmpXteN1PJEHMV8rvfeBXK6Eb4z6BgZwa8Ojavi1y9pKN-jA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CA+CmpXteN1PJEHMV8rvfeBXK6Eb4z6BgZwa8Ojavi1y9pKN-jA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yehezkel Bernat <yehezkelshb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Mario Limonciello <Mario.Limonciello-8PEkshWhKlo@public.gmane.org>, michael.jamet-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Christian Kellner <ckellner-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, Anthony Wong <anthony.wong-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andreas Noever <andreas.noever-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org, jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Nov 13, 2018 at 05:38:53PM +0200, Yehezkel Bernat wrote:
> Good point. But I thought about per-TBT-device decision. If the platform is
> configured for IOMMU+"user" security level, while approving the device the user
> may want to set also in which IOMMU group to put all the PCIe devices connected
> to it. The same goes if kernel is supposed to auto-approve such devices based on
> an internal table. The point is that we can think on a configuration where the
> devices aren't tunneled yet and the decision about IOMMU can still be changed.

Right, some of these systems have security level set to "user" so there
we could have a way to put the device into passthrough mode before it
appears on the PCIe bus. That would require some sort of API on the
IOMMU side, though.

> As you mentioned this isn't the common configuration anyway, so it probably
> doesn't worth all this hassle.

AFAIK mixing the two is not something they are going to be supporting in
Windows so I would not expect it to be common. I think the ultimate goal
is to move away from security levels towards IOMMU DMA protection so in
future I would expect more and more systems with IOMMU enabled +
security level set to "none".

So I agree with you that it probably is not worth doing at least without
having more data about real performance issues around this. ;-)
