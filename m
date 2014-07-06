From: "Gabbay, Oded" <Oded.Gabbay-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/6] mmput: use notifier chain to call subsystem exit
	handler.
Date: Sun, 6 Jul 2014 19:25:18 +0000
Message-ID: <019CCE693E457142B37B791721487FD918085329@storexdag01.amd.com>
References: <20140630160604.GF1956@gmail.com>
	<20140630181623.GE26537@8bytes.org> <20140630183556.GB3280@gmail.com>
	<20140701091535.GF26537@8bytes.org>
	<019CCE693E457142B37B791721487FD91806DD8B@storexdag01.amd.com>
	<20140701110018.GH26537@8bytes.org> <20140701193343.GB3322@gmail.com>
	<20140701210620.GL26537@8bytes.org> <20140701213208.GC3322@gmail.com>
	<20140703183024.GA3306@gmail.com> <20140703231541.GR26537@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140703231541.GR26537-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Content-Language: en-US
Content-ID: <0A58AD1CCF4E7042BF1AAC8E44083E23-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "SCheung-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <SCheung-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, "hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, "j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "aarcange-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <aarcange-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "jakumar-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <jakumar-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "ldunning-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <ldunning-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "mgorman-l3A5Bk7waGM@public.gmane.org" <mgorman-l3A5Bk7waGM@public.gmane.org>, "jweiner-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <jweiner-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "sgutti-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <sgutti-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "riel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <riel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Bridgman,
	John" <John.Bridgman-5C7GfCeVMHo@public.gmane.org>, "jhubbard-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <jhubbard-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "mhairgrove-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <mhairgrove-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "cabuschardt-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <cabuschardt-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "dpoole-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <dpoole-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Cornwall,
	Jay" <Jay.Cornwall-5C7GfCeVMHo@public.gmane.org>, "Lewycky, Andrew" <Andrew.Lewycky-5C7GfCeVMHo@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iom
List-Id: iommu@lists.linux-foundation.org

On Fri, 2014-07-04 at 01:15 +0200, Joerg Roedel wrote:
> Hi Jerome,
> 
> On Thu, Jul 03, 2014 at 02:30:26PM -0400, Jerome Glisse wrote:
> > Joerg do you still object to this patch ?
> 
> Yes.
> 
> > Again the natural place to call this is from mmput and the fact that many
> > other subsystem already call in from there to cleanup there own per mm data
> > structure is a testimony that this is a valid use case and valid design.
> 
> Device drivers are something different than subsystems. 
I think that hsa (kfd) and hmm _are_ subsystems, if not in definition
than in practice. Our model is not a classic device-driver model in the
sense that our ioctl's are more like syscalls than traditional
device-driver ioctls. e.g our kfd_open() doesn't open a kfd device or
even a gpu device, it *binds* a *process* to a device. So basically, our
ioctls are not related to a specific H/W instance (specific GPU in case
of kfd) but more related to a specific process.

Once we can agree on that, than I think we can agree that kfd and hmm
can and should be bounded to mm struct and not file descriptors.

	Oded

> I think the
> point that the mmu_notifier struct can not be freed in the .release
> call-back is a weak reason for introducing a new notifier. In the end
> every user of mmu_notifiers has to call mmu_notifier_register somewhere
> (file-open/ioctl path or somewhere else where the mm<->device binding is
>  set up) and can call mmu_notifier_unregister in a similar path which
> destroys the binding.
> 
> > You pointed out that the cleanup should be done from the device driver file
> > close call. But as i stressed some of the new user will not necessarily have
> > a device file open hence no way for them to free the associated structure
> > except with hackish delayed job.
> 
> Please tell me more about these 'new users', how does mm<->device binding
> is set up there if no fd is used?
> 
> 
> 	Joerg
> 
> 
