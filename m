From: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH v2 1/2] pci: Create PCIe requester ID interface
Date: Thu, 3 Apr 2014 15:48:57 -0600
Message-ID: <CAErSpo5p+6yt8ZyVuLnJTiKAWZWq9ixQQu78nD-bNFkw4ntWmw@mail.gmail.com>
References: <20130711204439.1701.90503.stgit@bling.home>
	<20130711210326.1701.56478.stgit@bling.home>
	<20130723223533.GB19765@google.com>
	<1374621703.15429.98.camel@ul30vt.home>
	<CAErSpo6bcGCjqdxn-bz_vjo+HsAiOxDu=--mD7veEZ9f7k+gyA@mail.gmail.com>
	<1374689548.5208.62.camel@ul30vt.home>
	<20130724232427.GA9272@google.com>
	<1374775016.2642.116.camel@ul30vt.home>
	<20130726215435.GB20021@google.com>
	<1375113975.2642.208.camel@ul30vt.home>
	<CAErSpo7pfCtTm5Cq=VixPTKMpM4VQpDr+ZmS5qMw32z6ABu0xQ@mail.gmail.com>
	<1375137140.2642.349.camel@ul30vt.home>
	<CAErSpo5+-r3qMca1_Kvt3jJ6OP6Q7--4VmTo3fWJ0y4CPewgEQ@mail.gmail.com>
	<1375462795.31262.327.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1375462795.31262.327.camel-85EaTFmN5p//9pzu0YdTqQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:INTEL IOMMU (VT-d)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, George Spelvin <linux-gpGsJRJZ3PBBDgjK7y7TUQ@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

[+cc George]

On Fri, Aug 2, 2013 at 10:59 AM, Alex Williamson
<alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> ...
> Great!  I'm still trying to figure out how to handle the quirk around
> Intel PCI-to-PCI bridge on the root complex as just another quirk.  I
> respin another version once I have that worked out.  Thanks,

Is anything happening here?  These buggy IOMMU/DMA source problems,
e.g., [1], have been lingering a long time, and I don't know if we're
stuck because I haven't been giving them enough attention, or if we
don't really have a good solution yet.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=42679
