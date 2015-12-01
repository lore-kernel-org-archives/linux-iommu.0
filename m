From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 0/8] iommu: Make core iommu-groups code more generic
Date: Tue, 1 Dec 2015 19:29:51 +0800
Message-ID: <1448969391.32066.28.camel@mhfsdcap03>
References: <1445464303-18206-1-git-send-email-joro@8bytes.org>
	<1447920801.27650.49.camel@mhfsdcap03>
	<20151119134114.GC2064@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20151119134114.GC2064-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 2015-11-19 at 14:41 +0100, Joerg Roedel wrote:
> Hi Yong Wu,
> 
> On Thu, Nov 19, 2015 at 04:13:21PM +0800, Yong Wu wrote:
> > (151119_13:39:37.472)WARNING:
> > at /proj/mtk40525/upstreamdev/v4.4/kernel/mediatek/drivers/iommu/iommu.c:1154
> > (151119_13:39:37.472)Modules linked in:
> > (151119_13:39:37.472)CPU: 1 PID: 731 Comm: sh Not tainted 4.4.0-rc1+
> > #37
> > (151119_13:39:37.472)Hardware name: MediaTek MT8173 evaluation board
> > (DT)
> > (151119_13:39:37.472)task: ffffffc076bb4d00 ti: ffffffc076bdc000
> > task.ti: ffffffc076bdc000
> > (151119_13:39:37.472)PC is at iommu_detach_device+0x5c/0xb0
> > (151119_13:39:37.472)LR is at iommu_detach_device+0x30/0xb0
> > xxx
> 
> This warning triggers when you use iommu_detach_device() with a device
> that is in a group with other devices. For those devices you must
> attach/detach the whole group of devices.
> 
> For that you have to use iommu_detach_group() and iommu_attach_group().
> 
> 
> 	Joerg
> 

     Currently We have to use iommu_detach_group and iommu_attach_group.
Is there any plan for adding detach/attach the device within a iommu
group?

Why I ask this is because that:

    There are 2 interfaces in MTK-SMI patch, named by
mtk_smi_larb_get/mtk_smi_larb_put which help enable/disable the
power-domain and clocks for each a device(local arbiter).
Take a example, VIDEO have to call mtk_smi_larb_get to enable its power
and clocks before it works and call mtk_smi_larb_put to disable them
after it work done.

    If the iommu support attach/detach the device in a iommu-group, then
we could request VIDEO to call iommu_attach_device before it works(the
mtk_iommu_attach_device will call the smi interface to enable its power,
clocks and enable iommu).and call iommu_detach_device after it work
done. then the VIDEO could call iommu_attach_device/iommu_detach_device
instead of talking with SMI directly.
