From: Bart Van Assche <bvanassche-HInyCGIudOg@public.gmane.org>
Subject: Re: kernel BUG at drivers/iommu/intel-iommu.c:608
Date: Mon, 08 Apr 2019 08:13:34 -0700
Message-ID: <1554736414.118779.265.camel@acm.org>
References: <a523ea10-3dab-fa2c-1ecf-5cf32077565f@acm.org>
	<20190407150650.060cc508@x1.home>
	<8d876549-21da-e027-0157-8737b10e26f8@acm.org>
	<20190407173132.24032810@x1.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7055709260679886307=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190407173132.24032810-hfcDOgR9qeA@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, James Smart <jsmart2021-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============7055709260679886307==
Content-Type: text/plain; charset="UTF-7"
Content-Transfer-Encoding: 7bit

On Sun, 2019-04-07 at 17:31 -0600, Alex Williamson wrote:
+AD4 It's not possible to do what you want with this configuration.  An IOMMU
+AD4 group represents the smallest set of devices that are isolated from
+AD4 other sets of devices and is also therefore the minimum granularity we
+AD4 can assign devices to userspace (ex. QEMU).  The kernel reacts to
+AD4 breaking the isolation of the group with a BUG+AF8-ON.  If you managed not
+AD4 to hit the BUG+AF8-ON here, you'd hit the BUG+AF8-ON in vfio code when the loss
+AD4 of isolation is detected there. IOMMU groups are formed at the highest
+AD4 point in the topology which guarantees isolation.  This can be
+AD4 indicated either via native PCIe ACS support or ACS-equivalent quirks
+AD4 in the code.  If the root port provides neither of these, then all
+AD4 devices downstream are grouped together as well as all peer root ports
+AD4 in the same PCI slot and all devices downstream of those.  If a
+AD4 multifunction endpoint does not provide ACS or equivalent quirks, the
+AD4 functions will be grouped together. Not all endpoint devices or systems
+AD4 are designed for minimum possible granularity.  You can learn more
+AD4 here+AFs-1+AF0.  Thanks,
+AD4 
+AD4 Alex
+AD4 
+AD4 +AFs-1+AF0 http://vfio.blogspot.com/2014/08/iommu-groups-inside-and-out.html

Hi Alex,

Thank you for the detailed reply. The background information you provided
makes it very clear why the devices I mentioned in my e-mail ended up in the
same IOMMU group.

But it seems that I was not clear enough in my original e-mail. My concern is
that a user space action (modprobe) should never trigger a kernel BUG(). Is
there any way to make sure that the sequence of actions I performed causes
modprobe to fail with an error code instead of triggering a kernel BUG()?

Thanks,

Bart.

--===============7055709260679886307==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7055709260679886307==--
