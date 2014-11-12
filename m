From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iommu/amd: fix accounting of device_state
Date: Wed, 12 Nov 2014 15:02:47 +0100
Message-ID: <20141112140247.GU10744@8bytes.org>
References: <1415614899-12602-1-git-send-email-oded.gabbay@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1415614899-12602-1-git-send-email-oded.gabbay-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Oded Gabbay <oded.gabbay-5C7GfCeVMHo@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Nov 10, 2014 at 12:21:39PM +0200, Oded Gabbay wrote:
> This patch fixes a bug in the accounting of the device_state.
> In the current code, the device_state was put (decremented) too many times,
> which sometimes lead to the driver getting stuck permanently in
> put_device_state_wait(). That happen because the device_state->count would go
> below zero, which is never supposed to happen.
> 
> The root cause is that the device_state was decremented in put_pasid_state()
> and put_pasid_state_wait() but also in all the functions that call those
> functions. Therefore, the device_state was decremented twice in each of these
> code paths.
> 
> The fix is to decouple the device_state accounting from the pasid_state
> accounting - remove the call to put_device_state() from the
> put_pasid_state() and the put_pasid_state_wait())

Right, there was a double drop of the reference to device state. An
alternative would have been to remove the put_device_state call at the
end of the amd_iommu_unbind_pasid() function. But this patch works as
well and is slightly better, so: Applied, thanks.


	Joerg
