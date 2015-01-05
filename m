From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 1/2] iommu/vt-d: Fix dmar_domain leak in
	iommu_attach_device
Date: Mon, 5 Jan 2015 11:59:37 +0100
Message-ID: <20150105105937.GA6638@suse.de>
References: <1418813017-24888-1-git-send-email-joro@8bytes.org>
	<20141217213747.GA11569@anatevka.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141217213747.GA11569-dMAi7lA+vBPDUbYHzcRnttBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jerry Hoemann <jerry.hoemann-VXdhtT5mjnY@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Myron Stowe <mstowe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Jerry,

On Wed, Dec 17, 2014 at 02:37:47PM -0700, Jerry Hoemann wrote:
> Before applying this change on a 3.18-rc7 kernel layered on a
> RHEL 7.0 root disk, I was able to reproduce the memory
> leak that Alex reported when powering on/off a VM w/ a PCI
> device assigned to it.
> 
> After applying this change, I don't see the memory leak anymore.
> Instrumentation shows the new code is being invoked during power on
> of the VM.
> 
> Looks good.
> 
> Thanks!
> 
> Tested-by: Jerry Hoemann <jerry.hoemann-VXdhtT5mjnY@public.gmane.org>

Thanks for testing, I applied the patches to my iommu/fixes branch for
3.19.


	Joerg
