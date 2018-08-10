From: Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [PATCH] vfio/pci: Some buggy virtual functions incorrectly
	report 1 for intx.
Date: Fri, 10 Aug 2018 17:48:36 +0100
Message-ID: <20180810174836.66d9791b@alans-desktop>
References: <1533843426-79170-1-git-send-email-ashok.raj@intel.com>
	<20180809134417.50de7fe7@t450s.home>
	<20180809230311.GA79703@otc-nc-03>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180809230311.GA79703@otc-nc-03>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Gage Eads <gage.eads-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> The hardware isn't public yet, so can't talk about it :-(. Once this patch gets 
> merged, will let the OSV engagement folks drive it for inclusions. We 
> could mark this for stable, but i would rather wait until we know the 
> timeline when they are expecting it to be in. It shouldn't break anything
> since we are just enforcing the spec.

Until a new better spec appears...

I know there is always fun when it comes to the people involved in
such a screwup having to admit it in public but this should IMHO be
tied to a PCI identifier table so that we know what the afflicted
hardware is. Otherwise some day in the future SRIOV will grow new features
and we'll have no idea what particular devices we need to narrow the
workaround too and indeed not necessarily even know this device is the
only one, as we'll silently fix other stuff then have it break on us
later.

Alan
