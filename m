From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/8] iommu: Make core iommu-groups code more generic
Date: Thu, 19 Nov 2015 14:41:14 +0100
Message-ID: <20151119134114.GC2064@8bytes.org>
References: <1445464303-18206-1-git-send-email-joro@8bytes.org>
	<1447920801.27650.49.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1447920801.27650.49.camel@mhfsdcap03>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Yong Wu,

On Thu, Nov 19, 2015 at 04:13:21PM +0800, Yong Wu wrote:
> (151119_13:39:37.472)WARNING:
> at /proj/mtk40525/upstreamdev/v4.4/kernel/mediatek/drivers/iommu/iommu.c:1154
> (151119_13:39:37.472)Modules linked in:
> (151119_13:39:37.472)CPU: 1 PID: 731 Comm: sh Not tainted 4.4.0-rc1+
> #37
> (151119_13:39:37.472)Hardware name: MediaTek MT8173 evaluation board
> (DT)
> (151119_13:39:37.472)task: ffffffc076bb4d00 ti: ffffffc076bdc000
> task.ti: ffffffc076bdc000
> (151119_13:39:37.472)PC is at iommu_detach_device+0x5c/0xb0
> (151119_13:39:37.472)LR is at iommu_detach_device+0x30/0xb0
> xxx

This warning triggers when you use iommu_detach_device() with a device
that is in a group with other devices. For those devices you must
attach/detach the whole group of devices.

For that you have to use iommu_detach_group() and iommu_attach_group().


	Joerg
