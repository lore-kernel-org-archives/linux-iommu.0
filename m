From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC] iommu: arm-smmu: stall support
Date: Wed, 27 Sep 2017 14:15:40 +0200
Message-ID: <20170927121540.GL8398@8bytes.org>
References: <20170914194444.32551-1-robdclark@gmail.com>
	<20170919123038.GF8398@8bytes.org>
	<CAF6AEGuutkqjrWk4jagE=p-NwHgxdiPZjjsaFsfwtczK568j+A@mail.gmail.com>
	<20170922090204.GJ8398@8bytes.org>
	<32e3ab2c-a996-c805-2a0d-a2e85deb3a50@arm.com>
	<CAF6AEGuh0FiNWEAmFm+7-7pc6MV5hKKz9cyA_J0d256bY-nYOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAF6AEGuh0FiNWEAmFm+7-7pc6MV5hKKz9cyA_J0d256bY-nYOQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Rob, Jean,

On Fri, Sep 22, 2017 at 02:42:44PM -0400, Rob Clark wrote:
> I'm in favour if splitting the reporting *somehow*.. the two
> approaches that seemed sane are:
> 
> 1) call fault handler from irq and having separate domain->resume()
> called by the driver, potentially from a wq
> 2) or having two fault callbacks, first called before wq and then
> based on returned value, optionally 2nd callback called from wq
> 
> The first seemed less intrusive to me, but I'm flexible.

How about adding a flag to the fault-handler call-back that tells us
whether it wants to sleep or not. If it wants, we call it from a wq, if
not we call call it directly like we do today in the
report_iommu_fault() function.

In any case we call iommu_ops->resume() when set on completion of the
fault-handler either from the workqueue or report_iommu_fault itself.


Regards,

	Joerg
