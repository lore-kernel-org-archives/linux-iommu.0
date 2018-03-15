From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH 05/10] iommu/amd: remove the special case from
	get_irq_table()
Date: Thu, 15 Mar 2018 16:25:51 +0100
Message-ID: <20180315152551.vsut2dt7b2m7guyu@linutronix.de>
References: <20180223222736.18542-1-bigeasy@linutronix.de>
	<20180223222736.18542-6-bigeasy@linutronix.de>
	<20180315125342.q74wurk6bdbhl6hy@8bytes.org>
	<20180315130153.3ba2loj5oplogdew@linutronix.de>
	<20180315130723.dunmpmbkswwvq54g@8bytes.org>
	<20180315141541.6g3xc6yi4siafuwr@linutronix.de>
	<20180315151917.pgheszruqnnjbqb4@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180315151917.pgheszruqnnjbqb4-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 2018-03-15 16:19:17 [+0100], Joerg Roedel wrote:
> Okay, if the irq-layer does the needed locking, then we don't need
> another lock here. There is the modify_irte_ga() path for the
> virtualized irq routing into KVM guests, but there should be no KVM
> guests running when setup the ioapic routing entries.

okay then. Let me rebase the queue on top whatever you have now and then
if the box still boots I will post them again.

> 	Joerg

Sebastian
