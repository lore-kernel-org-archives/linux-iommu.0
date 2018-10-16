From: Sedat Dilek <sedat.dilek-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Linux-4.19] ThinkPad T470 not booting with "intel_iommu=on"
Date: Tue, 16 Oct 2018 11:08:29 +0200
Message-ID: <CA+icZUV6U+4prwoKi53RvkH-0qpaAv7KkPmkeHnsKY9NpTrpNg@mail.gmail.com>
References: <CA+icZUXnB2LbB-X_pQeM=OQDEVcWQdUr9TLbG1cXnpwuTe=mNw@mail.gmail.com>
	<95f69db6-becd-adce-5477-264de839bcd8@linux.intel.com>
	<CA+icZUV8rEsY890jSd7K1+KQFUNC4MQk3z9MPBT8fpdTEG3X_w@mail.gmail.com>
	<cc4d8a8e-bf00-7a43-f022-baeb7628a238@linux.intel.com>
	<CA+icZUXdr7_3BcunvQ8D8JE1KYhyVoERKBbLzANOR5D7GgZKuA@mail.gmail.com>
Reply-To: sedat.dilek-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CA+icZUXdr7_3BcunvQ8D8JE1KYhyVoERKBbLzANOR5D7GgZKuA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Looked through my personal notes when I played with Intel-IOMMU and
found this useful web-link:

VFIO tips and tricks: "Intel-IOMMU: enabled": It doesn't mean what you
think it means (see [1]).

- Sedat -

[1] https://vfio.blogspot.com/2016/09/intel-iommu-enabled-it-doesnt-mean-what.html
