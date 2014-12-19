From: Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [v3 25/26] KVM: Suppress posted-interrupt when 'SN' is set
Date: Fri, 19 Dec 2014 13:00:37 +0100
Message-ID: <54941365.60604@redhat.com>
References: <1418397300-10870-1-git-send-email-feng.wu@intel.com>	<1418397300-10870-26-git-send-email-feng.wu@intel.com>	<5491C0A2.7040503@redhat.com>	<E959C4978C3B6342920538CF579893F002307C4A@SHSMSX104.ccr.corp.intel.com>	<5492926E.8070207@redhat.com>	<A9667DDFB95DB7438FA9D7D576C3D87E0AC04938@SHSMSX104.ccr.corp.intel.com>	<E959C4978C3B6342920538CF579893F00230ABEB@SHSMSX104.ccr.corp.intel.com>	<A9667DDFB95DB7438FA9D7D576C3D87E0AC04FED@SHSMSX104.ccr.corp.intel.com>	<E959C4978C3B6342920538CF579893F00230ADA0@SHSMSX104.ccr.corp.intel.com>	<A9667DDFB95DB7438FA9D7D576C3D87E0AC05059@SHSMSX104.ccr.corp.intel.com>	<E959C4978C3B6342920538CF579893F00230AE04@SHSMSX104.ccr.corp.intel.com>
	<A9667DDFB95DB7438FA9D7D576C3D87E0AC050B1@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <A9667DDFB95DB7438FA9D7D576C3D87E0AC050B1-0J0gbvR4kTg/UvCtAeCM4rfspsVTdybXVpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yang Zhang <yang.z.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Wu, Feng" <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, KVM list <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



On 19/12/2014 06:25, Zhang, Yang Z wrote:
> I see your point. But from performance point, if we can schedule the
> vCPU to another PCPU to handle the interrupt, it would helpful. But I
> remember current KVM will not schedule the vCPU in run queue (even
> though it got preempted) to another pCPU to run(Am I right?). So it
> may hard to do it.

Yes.  If the vCPU is in the run queue, it means it exhausted its
quantum.  As Feng said, the scheduler can decide to migrate it to
another pCPU, or it can decide to leave it runnable but not start it.
KVM doesn't try to force the scheduler one way or the other.

If the vCPU is I/O bound, it will not exhaust its quantum and will not
be preempted.  It will block, and the wakeup vector will restart it.

I don't think urgent notifications are interesting.  If you want to do
real time work, pin the vCPU to a physical CPU, and isolate the pCPU
with isolcpus.  Then the vCPU will always be running.

Paolo
