From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/5] iommu/arm-smmu: add support for PCI master devices
Date: Fri, 4 Jul 2014 09:13:31 +0100
Message-ID: <20140704081331.GB23379@arm.com>
References: <1404125530-17984-1-git-send-email-will.deacon@arm.com>
	<1404125530-17984-3-git-send-email-will.deacon@arm.com>
	<a9de518782874b5c8ddd366e6617b8de@BL2PR03MB468.namprd03.prod.outlook.com>
	<20140703144341.GC14305@arm.com>
	<3b9f2103f5c44958a74f1e594a58d58a@BL2PR03MB468.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3b9f2103f5c44958a74f1e594a58d58a-AZ66ij2kwaacCcN9WK45f+O6mTEJWrR4XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
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
Cc: "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, Stuart Yoder <stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Jul 04, 2014 at 08:41:53AM +0100, Varun Sethi wrote:
> Hi Will,

Hey Varun,

> > Once Thierry's generic IOMMU binding is sorted, we should look at adding
> > support for the Stream ID description. Have you looked at that at all?
> > 
> Yes, I have looked at the bindings. Would we need to represent the stream
> ids for PCI devices in the device tree? Why do we want to depend on the
> firmware to map the requestor id to the stream id? It can be handled using
> the APIs proposed by Alex Williamson. This is similar to IOMMU group
> determination, which is handled by the IOMMU driver.

Well, there could easily be a fixed mapping from the ID at the host controller
and the ID seem by the SMMU (e.g. two host controllers sharing an SMMU?). I
don't think walking the PCI buses can help you there.

The way I was thinking to handle this is that we express SID = RID +
offset. In the device-tree, we can then describe a range of RIDs on the host
controller, a single offset, and we get back a range of SIDs.

In the worst case scenario, each RID maps to a totally random SID, so then
you have a huge table describing the mapping. I *think* this is actually
unlikely, and if we ever see such a device we can either have a large
mapping or put it into C code for that specific SoC (if it's really huge).

FWIW: I believe that the ACPI folks are thinking along similar lines.

Will
