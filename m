From: Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v8 11/13] KVM: Update Posted-Interrupts Descriptor when
	vCPU is blocked
Date: Wed, 16 Sep 2015 11:32:14 +0200
Message-ID: <55F9371E.8030701@redhat.com>
References: <1442393409-2623-1-git-send-email-feng.wu@intel.com>
	<1442393409-2623-12-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1442393409-2623-12-git-send-email-feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



On 16/09/2015 10:50, Feng Wu wrote:
>  		 * are two possible cases:
> -		 * 1. After running 'pi_pre_block', context switch
> +		 * 1. After running 'pre_block', context switch

Please fold this in the previous patch.

>  		 *    happened. For this case, 'sn' was set in
>  		 *    vmx_vcpu_put(), so we need to clear it here.
> -		 * 2. After running 'pi_pre_block', we were blocked,
> +		 * 2. After running 'pre_block', we were blocked,
>  		 *    and woken up by some other guy. For this case,

(Same).

> +	spin_lock(&per_cpu(blocked_vcpu_on_cpu_lock, cpu));
> +	list_for_each_entry(vcpu, &per_cpu(blocked_vcpu_on_cpu, cpu),
> +			blocked_vcpu_list) {
> +		struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
> +
> +		if (pi_test_on(pi_desc) == 1)
> +			kvm_vcpu_kick(vcpu);
> +	}
> +	spin_unlock(&per_cpu(blocked_vcpu_on_cpu_lock, cpu));
> +}

Please document the lock in Documentation/virtual/kvm/locking.txt.

Paolo
