From: Jan Kiszka <jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC] iommu/vt-d: Use the SIRTP when enabling remapping
Date: Wed, 10 Sep 2014 08:56:20 +0200
Message-ID: <540FF614.8000003@siemens.com>
References: <1410297096-54096-1-git-send-email-nzimmer@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1410297096-54096-1-git-send-email-nzimmer-sJ/iWh9BUns@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Nathan Zimmer <nzimmer-sJ/iWh9BUns@public.gmane.org>, jroedel-l3A5Bk7waGM@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Gary Kroening <gfk-sJ/iWh9BUns@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 2014-09-09 23:11, Nathan Zimmer wrote:
> The previous change (iommu/vt-d: Don't store SIRTP request) to this area
> caused a crash in our simulator. In particular is seems that by the time a
> UART interrupt is sent through the system, we don't see interrupt remapping
> to be enabled.  So the interrupt does not get translated to a logical
> interrupt and crashes.
> 
> OR'ing the SIRTP request to make sure it is seen but hopefully not sticky.
> This seems like a clean fix, at least on our simulator; if you don't agree,
> our simulator guy will take a closer look at our iommu model.

Check the VT-d spec (6.7, Set Interrupt Remapping Table Pointer
Operation): "Software must always follow the interrupt-remapping table
pointer set operation with a global invalidate of the IEC to ensure
hardware references the new structures *before* enabling interrupt
remapping." There is also (command register description): "If multiple
control fields in this register need to be modified, software must
serialize the modifications through multiple writes to this register."
This, in combination with the command registers description of bits 24
and 25 strongly suggests that your model is broken.

> 
> Found testing on our simulator, not real hardware.

Funnily, the original issue was found by the QEMU model of VT-d that
used to take the last cited sentence very strictly (I asked to remove it
due to the preexisting Linux versions).

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux
