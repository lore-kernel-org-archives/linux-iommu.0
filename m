From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Need information on type 2 IOMMU
Date: Sun, 9 Apr 2017 22:19:45 -0600
Message-ID: <20170409221945.2a7180d6@t450s.home>
References: <20170407191747.26618-1-jean-philippe.brucker@arm.com>
	<1b48daab-c9e1-84d1-78a9-84d3e2001f32@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1b48daab-c9e1-84d1-78a9-84d3e2001f32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: valmiki <valmikibow-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: virtio-dev-sDuHXQ4OtrM4h7I2RyI4rWD2FQJk+8+b@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, 10 Apr 2017 08:00:45 +0530
valmiki <valmikibow-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Hi All,
> 
> We have drivers/vfio/vfio_iommu_type1.c. what is type1 iommu? Is it 
> w.r.t vfio layer it is being referred?
> 
> Is there type 2 IOMMU w.r.t vfio? If so what is it?

type1 is the 1st type.  It's an arbitrary name.  There is no type2, yet.
